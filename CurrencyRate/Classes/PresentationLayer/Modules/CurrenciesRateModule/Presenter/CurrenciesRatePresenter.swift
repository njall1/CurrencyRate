//
//  CurrenciesRatePresenter.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class CurrenciesRatePresenter {
    weak var view: CurrenciesRateViewInput!
    private var storage: Pair
    
    var finishFlow: EmptyCallback?
    
    init(view: CurrenciesRateViewInput, pair: Pair) {
        self.view = view
        self.storage = pair
    }
}

extension CurrenciesRatePresenter: CurrenciesRateModuleInput {
    func toPresent() -> UIViewController? {
        return view as? UIViewController
    }
}

extension CurrenciesRatePresenter: CurrenciesRateViewOutput {}
