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
        let pairs: [Pair]
    }
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private var storage = Storage(pairs: [])
    
    init(router: Router,
         coordinatorFactory: CoordinatorFactory)
    {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        super.start()
        let coordinator = self.coordinatorFactory.makeCurrencyRate(router: self.router, pairs: self.storage.pairs)
        
        self.runFlow(coordinator: coordinator) { [weak self] in
            self?.runAddCurrenciesPair()
        }
        
        coordinator.start()
    }
    
    private func runAddCurrenciesPair() {
        // TODO: Make correct filter for disabled currencies & move it to module presenter
        let disabledCurrencies = self.storage.pairs.map { $0.0 }
        
        let coordinator = self.coordinatorFactory.makeAddCurrencyPair(router: self.router,
                                                                      disabledCurrencies: disabledCurrencies)
        
        coordinator.selectedPair = { [weak self] pair in
            guard let self = self else { return }
            
            if self.storage.pairs.isEmpty {
                self.storage = Storage(pairs: [pair])
            } else {
                self.storage = Storage(pairs: self.storage.pairs + [pair])
            }
        }
        
        coordinator.runFlow(coordinator: coordinator) { [weak self] in
            self?.start()
        }
    
        coordinator.start()
    }
}
