//
//  CurrencyRateCoordinator.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CurrencyRateCoordinatorOutput: Finishable { }

final class CurrencyRateCoordinator: CommonCoordinator, CurrencyRateCoordinatorOutput {
    struct Storage {
        let currencies: [CurrencyEntity]
        static let empty = Storage(currencies: [])
    }
    
    private let currenciesRateModuleFactory: CurrenciesRateModuleFactory
    private let emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory
    private let router: Router
    private var storage = Storage.empty
    
    var finishFlow: EmptyCallback?
    
    init(router: Router,
         emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory,
         currenciesRateModuleFactory: CurrenciesRateModuleFactory)
    {
        self.router = router
        self.emptyCurrenciesRateModuleFactory = emptyCurrenciesRateModuleFactory
        self.currenciesRateModuleFactory = currenciesRateModuleFactory
    }
    
    override func start() {
        super.start()

        let module: Presentable & Finishable
        if self.storage.currencies.isEmpty {
            module = self.emptyCurrenciesRateModuleFactory.makeEmptyCurrenciesRateModule()
        } else {
            module = self.currenciesRateModuleFactory.makeCurrenciesRateModule()
        }
        
        module.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        
        self.router.setRootModule(module)
    }
}
