//
//  AddCurrencyPairCoordinator.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class AddCurrencyPairCoordinator: CommonCoordinator {
    private var modulesFactory: CurrenciesModuleFactory
    private var router: Router
    private var storage: PairsStorageServiceInput
    private var currenciesService: CurrenciesServiceInput
    private var helper: AddCurrencyPairCoordinatorHelperInput
    
    var finishFlow: EmptyCallback?
    
    init(router: Router, currenciesModuleFactory: CurrenciesModuleFactory, storage: PairsStorageServiceInput, currenciesService: CurrenciesServiceInput, helper: AddCurrencyPairCoordinatorHelperInput) {
        self.router = router
        self.modulesFactory = currenciesModuleFactory
        self.currenciesService = currenciesService
        self.storage = storage
        self.helper = helper
    }
    
    override func start() {
        super.start()
        
        let disabledCurrencies = self.helper.makeDisabledCurrenies(availableCurrencies: currenciesService.fetchCurrencies(), pairs: self.storage.pairs)
        let module = self.modulesFactory.makeCurrencyModule(disabledCurrencies: disabledCurrencies)
        
        module.selectedCurrency = { [weak self] currency in
            guard let self = self else { return }
            
            let disabledCurrencies = self.helper.makeDisabledCurrencies(currency: currency, pairs: self.storage.pairs)
            let pairModule = self.modulesFactory.makeCurrencyModule(disabledCurrencies: disabledCurrencies)
        
            pairModule.selectedCurrency = { [weak self] secondCurrency in
                guard let self = self else { return }
                self.storage.pairs = self.storage.pairs + [PairEntity(first: currency, second: secondCurrency)]
            }
            
            pairModule.finishFlow = { [weak self] in
                self?.finishFlow?()
            }
        
            self.router.push(module: pairModule)
        }
        
        self.router.setRootModule(module)
    }
}

extension AddCurrencyPairCoordinator: Finishable {}
