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
        var pairs: [Pair]
    }
    
    private let coordinatorFactory: CoordinatorFactory
    private let currenciesRateModuleFactory: CurrenciesRateModuleFactory
    private let router: Router
    private let storageService: StorageServiceInput
    private var storage: Storage
    
    init(router: Router, coordinatorFactory: CoordinatorFactory, currenciesRateModuleFactory: CurrenciesRateModuleFactory) {
        self.storageService = ServiceLocator.sharedInstance.getService()
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.currenciesRateModuleFactory = currenciesRateModuleFactory
        self.storage = Storage(pairs: self.storageService.fetchPairsFromStorage())
    }
    
    override func start() {
        super.start()
        
        let module: CurrenciesRateModuleInput = self.currenciesRateModuleFactory.makeCurrenciesRateModule(pairs: self.storage.pairs)
        
        module.deletedItem = { [weak self] row in
            self?.storage.pairs.remove(at: row)
        }
        
        module.finishFlow = { [weak self] in
            self?.runAddCurrenciesPair()
        }
        
        self.router.setRootModule(module)
    }
    
    private func runAddCurrenciesPair() {
        // TODO: Make correct filter for disabled currencies & move it to module presenter
        let disabledCurrencies = self.storage.pairs.map { $0.first }
        
        let coordinator = self.coordinatorFactory.makeAddCurrencyPair(router: self.router,
                                                                      disabledCurrencies: disabledCurrencies)
        
        coordinator.selectedPair = { [weak self] pair in
            guard let self = self else { return }
            
            self.storage.pairs.append(pair)
            self.storageService.savePairsToStorage(self.storage.pairs)
        }
        
        coordinator.runFlow(coordinator: coordinator) { [weak self] in
            self?.start()
        }
    
        coordinator.start()
    }
}

private extension ApplicationCoordinator {
    func updatePairsIfNeeded() {
        let fetchedPairs = self.storageService.fetchPairsFromStorage()
        if !fetchedPairs.isEmpty {
            self.storage.pairs = fetchedPairs
        }
    }
}
