//
//  CurrencyRateCoordinator.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CurrencyRateCoordinatorOutput: Finishable { }

final class CurrenciesRateCoordinator: CommonCoordinator, CurrencyRateCoordinatorOutput {
    struct Storage {
        let pairs: [Pair]
    }
    
    private let currenciesRateModuleFactory: CurrenciesRateModuleFactory
    private let emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory
    private let router: Router
    private var storage = Storage(pairs: [])
    
    var finishFlow: EmptyCallback?
    
    init(router: Router,
         emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory,
         currenciesRateModuleFactory: CurrenciesRateModuleFactory,
         pairs: [Pair])
    {
        self.storage = Storage(pairs: pairs)
        self.router = router
        self.emptyCurrenciesRateModuleFactory = emptyCurrenciesRateModuleFactory
        self.currenciesRateModuleFactory = currenciesRateModuleFactory
    }
    
    override func start() {
        super.start()

        let module: Presentable & Finishable
        if !self.storage.pairs.isEmpty {
            module = self.currenciesRateModuleFactory.makeCurrenciesRateModule(pairs: self.storage.pairs)
        } else {
            module = self.emptyCurrenciesRateModuleFactory.makeEmptyCurrenciesRateModule()
        }
        
        module.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        
        self.router.setRootModule(module)
    }
}
