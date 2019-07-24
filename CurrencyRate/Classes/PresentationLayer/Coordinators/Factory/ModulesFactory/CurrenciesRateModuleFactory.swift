//
//  CurrenciesRateModuleFactory.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CurrenciesRateModuleFactory {
    func makeCurrenciesRateModule(pairs: [Pair]) -> CurrenciesRateModuleInput
}