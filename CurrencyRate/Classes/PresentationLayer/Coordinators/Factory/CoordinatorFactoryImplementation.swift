//
//  CoordinatorFactoryImplementation.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class CoordinatorFactoryImplementation: CoordinatorFactory {    
    func makeAddCurrencyPair(router: Router) -> Coordinator {
        return AddCurrencyPairCoordinator()
    }
    
    func makeCurrencyRate(router: Router, finishFlow: EmptyCallback?) -> Coordinator & CurrencyRateCoordinatorOutput  {
        let moduleFactory = ModuleFactoryImplementation()
        return CurrencyRateCoordinator(router: router, emptyCurrenciesRateModuleFactory: moduleFactory, finishFlow: finishFlow)
    }
}
