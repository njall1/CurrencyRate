//
//  ApplicationCoordinator.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 21/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: CommonCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private let currenciesRateModuleFactory: CurrenciesRateModuleFactory
    private let router: Routable
    
    init(router: Routable, coordinatorFactory: CoordinatorFactory, currenciesRateModuleFactory: CurrenciesRateModuleFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.currenciesRateModuleFactory = currenciesRateModuleFactory
    }
    
    override func start() {
        super.start()
        
        let module: CurrenciesRateModuleInput = self.currenciesRateModuleFactory.makeCurrenciesRateModule()
        
        module.finishFlow = { [weak self] in
            self?.runAddCurrenciesPair()
        }
        
        self.router.setRootModule(module)
    }
    
    private func runAddCurrenciesPair() {
        let coordinator = self.coordinatorFactory.makeAddCurrencyPair(router: self.router)
        coordinator.runFlow(coordinator: coordinator) { [weak self] in
            self?.start()
        }
    
        coordinator.start()
    }
}
