//
//  EmptyCurrenciesRatePresenter.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 21/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class EmptyCurrenciesRatePresenter {
    weak var view: EmptyCurrenciesRateViewInput!
    private var finishHandler: (() -> Void)?
}

extension EmptyCurrenciesRatePresenter: EmptyCurrenciesRateModuleInput {
    func configureModule(completionHandler: @escaping EmptyCallback) {
        self.finishHandler = completionHandler
    }
}

extension EmptyCurrenciesRatePresenter: EmptyCurrenciesRateViewOutput {
    func userDidClickAddCurrencyPair() {
        self.finishHandler?()
    }
}
