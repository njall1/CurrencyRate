//
//  AddRatePresenter.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class CurrenciesPresenter {
    private weak var view: CurrenciesViewInput!
    private var currenciesService: CurenciesServiceInput
    private var dataSource = [CurrencyEntity]()
    private var disabledCurrencies = [CurrencyEntity]()
    
    var selectedCurrency: CurrencyCallback?
    var finishFlow: EmptyCallback?
    
    init(view: CurrenciesViewInput, currenciesService: CurenciesServiceInput) {
        self.view = view
        self.currenciesService = currenciesService
    }
}

extension CurrenciesPresenter: CurrenciesModuleInput {
    func toPresent() -> UIViewController? {
        return self.view as? UIViewController
    }
    
    func configureModule(disabledCurrencies: [CurrencyEntity]) {
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
                self.view.showCurrencies(currencies.map {
                    let alpha: CGFloat = self.isDisabledCurrency(currency: $0) ? Constants.disabledAlpha : Constants.normalAlpha
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
    func didSelectRowAt(index: Int) {
        guard !self.isDisabledCurrency(currency: self.dataSource[index])
            else { return }
        
        self.selectedCurrency?(self.dataSource[index])
        self.finishFlow?()
    }
}

private extension CurrenciesPresenter {
    func isDisabledCurrency(currency: CurrencyEntity) -> Bool {
        guard !self.disabledCurrencies.isEmpty else { return false }
        return self.disabledCurrencies.contains(where: { $0.code == currency.code })
    }
}
