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
        let pair: Pair?
    }
    
    private let currenciesRateModuleFactory: CurrenciesRateModuleFactory
    private let emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory
    private let router: Router
    private var storage = Storage(pair: nil)
    
    var finishFlow: EmptyCallback?
    
    init(router: Router,
         emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory,
         currenciesRateModuleFactory: CurrenciesRateModuleFactory,
         pair: Pair?)
    {
        self.storage = Storage(pair: pair)
        self.router = router
        self.emptyCurrenciesRateModuleFactory = emptyCurrenciesRateModuleFactory
        self.currenciesRateModuleFactory = currenciesRateModuleFactory
    }
    
    override func start() {
        super.start()

        let module: Presentable & Finishable
        if let pair = self.storage.pair {
            module = self.currenciesRateModuleFactory.makeCurrenciesRateModule(pair: pair)
        } else {
            module = self.emptyCurrenciesRateModuleFactory.makeEmptyCurrenciesRateModule()
        }
        
        module.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        
        self.router.setRootModule(module)
    }
}
