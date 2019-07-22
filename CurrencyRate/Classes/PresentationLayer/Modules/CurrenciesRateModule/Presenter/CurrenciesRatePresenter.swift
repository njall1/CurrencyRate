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
    
    var finishFlow: EmptyCallback?
    
    init(view: CurrenciesRateViewInput) {
        self.view = view
    }
}

extension CurrenciesRatePresenter: CurrenciesRateModuleInput {
    func toPresent() -> UIViewController? {
        return view as? UIViewController
    }
}

extension CurrenciesRatePresenter: CurrenciesRateViewOutput {}
