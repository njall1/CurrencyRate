//
//  ApplicationCoordinator.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 21/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: CommonCoordinator {
    struct Storage {
        let currencies: [CurrencyEntity]
        static let empty = Storage(currencies: [])
    }
    
    private let coordinatorFactory: CoordinatorFactory
    private let emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory
    private let router: Router
    private var storage = Storage.empty
    
    init(router: Router,
         coordinatorFactory: CoordinatorFactory,
         emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory)
    {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.emptyCurrenciesRateModuleFactory = emptyCurrenciesRateModuleFactory
    }
    
    override func start() {
        super.start()
        
        if storage.currencies.isEmpty {
            self.showEmptyCurrenciesRateModule()
        } else {
            self.showCurrenciesRateModule()
        }
    }
}

private extension ApplicationCoordinator {
    func showEmptyCurrenciesRateModule() {
        let coordinator = self.coordinatorFactory.makeAddCurrencyPair(router: self.router)
        let emptyCurrenciesModule = self.emptyCurrenciesRateModuleFactory.makeEmptyCurrenciesRateModule()
        emptyCurrenciesModule.configureModule { [weak self, weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            self.addDependency(coordinator)
            coordinator.start()
        }
    
        self.router.setRootModule(emptyCurrenciesModule)
    }
    
    func showCurrenciesRateModule() {
        
    }
}
