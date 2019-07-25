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
    func makeCurrenciesRateModule(pairs: [Pair]) -> CurrenciesRateModuleInput {
        guard let module = CurrenciesRateAssembly.makeCurrenciesRateModule(pairs: pairs)
            else { fatalError("DI Error for CurrenciesRateAssembly.") }
        return module
    }
}

extension ModuleFactoryImplementation: CurrenciesModuleFactory {
    func makeCurrencyModule(disabledCurrencies: [CurrencyEntity]) -> CurrenciesModuleInput {
        guard let module = CurrenciesAssembly.makeCurrenciesModule()
            else { fatalError("DI Error for CurrenciesRateAssembly.") }
        module.configureModule(disabledCurrencies: disabledCurrencies)
        return module
    }
}
