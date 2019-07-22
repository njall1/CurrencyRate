//
//  CurrenciesRatePresenter.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class CurrenciesRatePresenter {
    weak var view: CurrenciesRateViewInput!
    
    init(view: CurrenciesRateViewInput) {
        self.view = view
    }
}

extension CurrenciesRatePresenter: CurrenciesRateViewOutput {}
