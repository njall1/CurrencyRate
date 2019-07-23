//
//  CoordinatorFactoryImplementation.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class CoordinatorFactoryImplementation: CoordinatorFactory {    
    func makeAddCurrencyPair(router: Router, disabledCurrencies: [CurrencyEntity]) -> Coordinator & AddCurrencyPairCoordinatorOutput {
        let moduleFactory = ModuleFactoryImplementation()
        return AddCurrencyPairCoordinator(router: router,
                                          currenciesModuleFactory: moduleFactory,
                                          disabledCurrencies: disabledCurrencies)
    }
    
    func makeCurrencyRate(router: Router, pairs: [Pair]) -> Coordinator & Finishable {
        let moduleFactory = ModuleFactoryImplementation()
        return CurrenciesRateCoordinator(router: router,
                                       emptyCurrenciesRateModuleFactory: moduleFactory,
                                       currenciesRateModuleFactory: moduleFactory,
                                       pairs: pairs)
    }
}
