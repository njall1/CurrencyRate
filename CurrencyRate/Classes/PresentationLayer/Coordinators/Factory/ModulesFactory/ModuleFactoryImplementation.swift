//
//  ModuleFactory.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class ModuleFactoryImplementation { }

extension ModuleFactoryImplementation: CurrenciesRateModuleFactory {
    func makeCurrenciesRateModule() -> CurrenciesRateModuleInput {
        guard let module = CurrenciesRateAssembly.makeCurrenciesRateModule(rateServie: ServiceLocator.sharedInstance.getService(), pairsStorage: ServiceLocator.sharedInstance.getService())
            else { fatalError("DI error for CurrenciesRateAssembly.") }
        return module
    }
}

extension ModuleFactoryImplementation: CurrenciesModuleFactory {
    func makeCurrencyModule(disabledCurrencies: [CurrencyEntity]) -> CurrenciesModuleInput {
        guard let module = CurrenciesAssembly.makeCurrenciesModule(currenciesService: ServiceLocator.sharedInstance.getService(), disabledCurrencies: disabledCurrencies)
            else { fatalError("DI error for CurrenciesAssembly.") }
        return module
    }
}
