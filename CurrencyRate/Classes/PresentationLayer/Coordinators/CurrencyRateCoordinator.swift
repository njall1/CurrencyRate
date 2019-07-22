//
//  CurrencyRateCoordinator.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CurrencyRateCoordinatorOutput: class {
    var finishFlow: (EmptyCallback)? { get set }
}

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
         currenciesRateModuleFactory: CurrenciesRateModuleFactory,
         finishFlow: EmptyCallback?)
    {
        self.router = router
        self.emptyCurrenciesRateModuleFactory = emptyCurrenciesRateModuleFactory
        self.currenciesRateModuleFactory = currenciesRateModuleFactory
        self.finishFlow = finishFlow
    }
    
    override func start() {
        super.start()

        let emptyModule: Presentable
        if self.storage.currencies.isEmpty {
            emptyModule = self.emptyCurrenciesRateModuleFactory.makeEmptyCurrenciesRateModule()
            
            emptyModule.finishFlow {
                [weak self] in
                
                self?.finishFlow?()
            }
        } else {
            emptyModule = self.currenciesRateModuleFactory.makeCurrenciesRateModule()
            
            emptyModule.finishFlow {
                [weak self] in
                
                self?.finishFlow?()
            }
        }
        
        
        
        self.router.setRootModule(emptyModule)
    }
}
