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
        return AddCurrencyPairCoordinator(router: router,
                                          currenciesModuleFactory: ModuleFactoryImplementation(),
                                          disabledCurrencies: disabledCurrencies)
    }
}
