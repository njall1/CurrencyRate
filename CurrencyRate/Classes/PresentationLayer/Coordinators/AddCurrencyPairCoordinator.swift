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
    
    private var storage: PairsStorageServiceInput = ServiceLocator.sharedInstance.getService()
    private var currencies: CurrenciesServiceInput = ServiceLocator.sharedInstance.getService()
    
    var finishFlow: EmptyCallback?
    var selectedPair: PairCallback?
    
    init(router: Router, currenciesModuleFactory: CurrenciesModuleFactory) {
        self.router = router
        self.modulesFactory = currenciesModuleFactory
    }
    
    override func start() {
        super.start()
        
        
        let module = self.modulesFactory.makeCurrencyModule(disabledCurrencies: self.getDisabled())
        
        module.selectedCurrency = { [weak self] currency in
            guard let self = self else { return }
            
            let pairModule = self.modulesFactory.makeCurrencyModule(disabledCurrencies: self.getDisabled(currency))
        
            pairModule.selectedCurrency = { [weak self] secondCurrency in
                self?.selectedPair?(PairEntity(first: currency, second: secondCurrency))
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

private extension AddCurrencyPairCoordinator {
    func getDisabled() -> [CurrencyEntity] {
        let allCurrencies = self.currencies.fetchCurrencies()
        var disabledList = [CurrencyEntity]()
        self.storage.pairs.forEach { pair in
            var allSelected = self.storage.pairs.filter { $0.first.code == pair.first.code }.map { $0.second }
            allSelected.append(pair.first)
            
            let disabledCurrency = allCurrencies.filter { !allSelected.contains($0) }.isEmpty
            if disabledCurrency, allSelected.count == allCurrencies.count {
                disabledList.append(pair.first)
            }
        }
        
        return disabledList
    }
    
    func getDisabled(_ currency: CurrencyEntity) -> [CurrencyEntity] {
        return self.storage.pairs.filter { $0.first == currency }.map { $0.second } + [currency]
    }
}
