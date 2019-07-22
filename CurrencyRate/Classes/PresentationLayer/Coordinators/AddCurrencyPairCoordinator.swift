//
//  AddCurrencyPairCoordinator.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class AddCurrencyPairCoordinator: CommonCoordinator {
    var finishFlow: EmptyCallback?
    var modulesFactory: CurrenciesModuleFactory
    var router: Router
    
    init(router: Router, currenciesModuleFactory: CurrenciesModuleFactory) {
        self.router = router
        self.modulesFactory = currenciesModuleFactory
    }
    
    override func start() {
        super.start()
        
        let module = self.modulesFactory.makeCurrencyModule(disabledCurrencies: [])
        
        module.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        
        module.selectedCurrency = { currency in
            print("Selected Currency: \(currency.code)")
        }
        
        self.router.setRootModule(module)
    }
}

extension AddCurrencyPairCoordinator: Finishable {}
