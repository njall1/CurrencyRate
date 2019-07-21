//
//  AddRatePresenter.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class CurrenciesPresenter {
    weak var view: CurrenciesViewInput?
    var currenciesService: CurenciesServiceInput
    
    private var finishHandler: ((String) -> Void)?
    private var dataSource = [CurrencyEntity]()
    private var disabledCurrencies = [CurrencyEntity]()
    
    init(view: CurrenciesViewInput, currenciesService: CurenciesServiceInput) {
        self.view = view
        self.currenciesService = currenciesService
    }
}

extension CurrenciesPresenter: CurrenciesModuleInput {
    func configureModule(disabledCurrencies: [CurrencyEntity], completionHandler: @escaping (String) -> Void) {
        self.finishHandler = completionHandler
        self.disabledCurrencies = disabledCurrencies
    }
}

extension CurrenciesPresenter: CurrenciesViewOutput {
    func viewDidLoad() {
        self.currenciesService.fetchCurencies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let currencies):
                self.dataSource = currencies
                self.view?.showCurrencies(currencies.map {
                    let alpha: CGFloat = self.isDisabledCurrency(currency: $0) ? 0.3 : 1.0
                    return CurrencyTableViewCell.DisplayItem(thumbnailName: $0.code,
                                                             thumbnailAlpha: alpha,
                                                             title: $0.code,
                                                             titleAlpha: alpha,
                                                             subtitle: $0.code,
                                                             subtitleAlpha: alpha)
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CurrenciesPresenter: CurrenciesAdapterDelegate {
    func didDeselectRowAt(index: Int) {
        guard !self.isDisabledCurrency(currency: self.dataSource[index]) else { return }
        self.finishHandler?(self.dataSource[index].code)
    }
}

private extension CurrenciesPresenter {
    func isDisabledCurrency(currency: CurrencyEntity) -> Bool {
        guard !self.disabledCurrencies.isEmpty else { return false }
        return self.disabledCurrencies.contains(where: { $0.code == currency.code })
    }
}
