//
//  EmptyCurrenciesRatePresenter.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 21/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class EmptyCurrenciesRatePresenter {
    weak var view: EmptyCurrenciesRateViewInput!
    private var finishHandler: (() -> Void)?
    
    init(view: EmptyCurrenciesRateViewInput) {
        self.view = view
    }
}

extension EmptyCurrenciesRatePresenter: EmptyCurrenciesRateModuleInput {
    func toPresent() -> UIViewController? {
        return self.view as? UIViewController
    }
    
    func configureModule(completionHandler: @escaping EmptyCallback) {
        self.finishHandler = completionHandler
    }
}

extension EmptyCurrenciesRatePresenter: EmptyCurrenciesRateViewOutput {
    func userDidClickAddCurrencyPair() {
        self.finishHandler?()
    }
}
