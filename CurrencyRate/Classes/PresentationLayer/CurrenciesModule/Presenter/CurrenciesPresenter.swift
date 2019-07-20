//
//  AddRatePresenter.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class CurrenciesPresenter {
    weak var view: CurrenciesViewInput?
    var currenciesService: CurenciesServiceInput
    
    private var finishHandler: ((String) -> Void)?
    private var dataSource: [CurrencyEntity] = []
    
    init(view: CurrenciesViewInput, currenciesService: CurenciesServiceInput) {
        self.view = view
        self.currenciesService = currenciesService
    }
}

extension CurrenciesPresenter: CurrenciesModuleInput {
    func configureModule(disabledCurrencies: [String], completionHandler: @escaping (String) -> Void) {
        self.finishHandler = completionHandler
        // TODO: Configure disabledCurrencies for module 
    }
}

extension CurrenciesPresenter: CurrenciesViewOutput {
    func viewDidLoad() {
        self.currenciesService.fetchCurencies { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.dataSource = currencies
                self?.view?.showCurrencies(currencies.map { CurrencyTableViewCell.DisplayItem(thumbnailIName: $0.code, title: $0.code, subtitle: $0.code) })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CurrenciesPresenter: CurrenciesAdapterDelegate {
    func didDeselectRowAt(index: Int) {
        self.finishHandler?(self.dataSource[index].code)
    }
}
