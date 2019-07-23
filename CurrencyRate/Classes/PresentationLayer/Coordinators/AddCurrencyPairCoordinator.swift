//
//  AddCurrencyPairCoordinator.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol AddCurrencyPairCoordinatorOutput: Finishable {
    var selectedPair: PairCallback? { get set }
}

final class AddCurrencyPairCoordinator: CommonCoordinator {
    private var modulesFactory: CurrenciesModuleFactory
    private var router: Router
    
    var finishFlow: EmptyCallback?
    var selectedPair: PairCallback?
    
    init(router: Router, currenciesModuleFactory: CurrenciesModuleFactory) {
        self.router = router
        self.modulesFactory = currenciesModuleFactory
    }
    
    override func start() {
        super.start()
        
        let module = self.modulesFactory.makeCurrencyModule(disabledCurrencies: [])
        
        module.selectedCurrency = { [weak self] currency in
            guard let self = self else { return }
            
            let pairModule = self.modulesFactory.makeCurrencyModule(disabledCurrencies: [currency])
        
            pairModule.selectedCurrency = { [weak self] secondCurrency in
                self?.selectedPair?((currency, secondCurrency))
            }
            
            pairModule.finishFlow = { [weak self] in
                self?.finishFlow?()
            }
        
            self.router.push(module: pairModule)
        }
        
        self.router.setRootModule(module)
    }
}

extension AddCurrencyPairCoordinator: AddCurrencyPairCoordinatorOutput {}
