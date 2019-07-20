//
//  AddRatePresenter.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class AddRatePresenter: AddRateModuleInput {
    weak var view: AddRateViewInput?
    var currenciesService: CurenciesServiceInput
    
    init(view: AddRateViewInput, currenciesService: CurenciesServiceInput) {
        self.view = view
        self.currenciesService = currenciesService
    }
}

extension AddRatePresenter: AddRateViewOutput {
    func viewDidLoad() {
        self.currenciesService.fetchCurencies { result in
            switch result {
            case .success(let currencies):
                self.view?.showCurrencies(currencies.map { AddRateTableViewCell.DisplayItem(thumbnailIName: $0.code, title: $0.code, subtitle: $0.code) })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension AddRatePresenter: AddRateAdapterDelegate {
    func didDeselectRowAt(index: Int) {
        
    }
}
