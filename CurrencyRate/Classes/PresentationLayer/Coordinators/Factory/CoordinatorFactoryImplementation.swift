//
//  CoordinatorFactoryImplementation.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class CoordinatorFactoryImplementation: CoordinatorFactory {    
    func makeAddCurrencyPair(router: Router) -> Coordinator & Finishable {
        return AddCurrencyPairCoordinator(router: router,
                                          currenciesModuleFactory: ModuleFactoryImplementation(),
                                          storage: ServiceLocator.sharedInstance.getService(),
                                          currenciesService: ServiceLocator.sharedInstance.getService(),
                                          helper: AddCurrencyPairCoordinatorHelper())
    }
}
