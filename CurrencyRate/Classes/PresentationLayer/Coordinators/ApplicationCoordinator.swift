//
//  ApplicationCoordinator.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 21/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: CommonCoordinator {
    struct Storage {
        let pair: Pair?
    }
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private var storage = Storage(pair: nil)
    
    init(router: Router,
         coordinatorFactory: CoordinatorFactory)
    {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        super.start()
        let coordinator = self.coordinatorFactory.makeCurrencyRate(router: self.router, pair: self.storage.pair)
        
        self.runFlow(coordinator: coordinator) { [weak self] in
            self?.runAddCurrenciesPair()
        }
        
        coordinator.start()
    }
    
    private func runAddCurrenciesPair() {
        let coordinator = self.coordinatorFactory.makeAddCurrencyPair(router: self.router)
        
        coordinator.selectedPair = { [weak self] pair in
            self?.storage = Storage(pair: pair)
        }
        
        coordinator.runFlow(coordinator: coordinator) { [weak self] in
            self?.start()
        }
    
        coordinator.start()
    }
}
