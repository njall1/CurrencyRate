//
//  CoordinatorFactory.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CoordinatorFactory {
    func makeAddCurrencyPair(router: Router, disabledCurrencies: [CurrencyEntity]) -> Coordinator & AddCurrencyPairCoordinatorOutput
    func makeCurrencyRate(router: Router, pairs: [Pair]) -> Coordinator & Finishable
}
