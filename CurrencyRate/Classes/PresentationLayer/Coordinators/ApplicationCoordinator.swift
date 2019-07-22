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
    private let router: Router
    
    init(router: Router,
         coordinatorFactory: CoordinatorFactory)
    {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        super.start()
        let coordinator = self.coordinatorFactory.makeCurrencyRate(router: self.router) {
            [weak self] in
            
            self?.runAddCurrenciesPair()
        }
        
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runAddCurrenciesPair() {
        let coordinator = self.coordinatorFactory.makeAddCurrencyPair(router: self.router)
        self.addDependency(coordinator)
        coordinator.start()
    }
}
