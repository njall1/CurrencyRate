//
//  CoordinatorFactoryImplementation.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class CoordinatorFactoryImplementation: CoordinatorFactory {    
    func makeAddCurrencyPair(router: Routable) -> Coordinatable & Finishable {
        return AddCurrencyPairCoordinator(router: router,
                                          currenciesModuleFactory: ModuleFactoryImplementation(),
                                          storage: ServiceLocator.sharedInstance.getService(),
                                          helper: AddCurrencyPairCoordinatorHelper())
    }
    
    func makeApplicationCoordinator(rootController: UINavigationController) -> Coordinatable {
        return ApplicationCoordinator(router: AppRouter(rootController: rootController),
                                      coordinatorFactory: CoordinatorFactoryImplementation(),
                                      currenciesRateModuleFactory: ModuleFactoryImplementation())
    }
}
