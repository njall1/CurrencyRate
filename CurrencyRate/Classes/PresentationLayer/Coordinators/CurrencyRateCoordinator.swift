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
    
    private let emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory
    private let router: Router
    private var storage = Storage.empty
    
    var finishFlow: (EmptyCallback)?
    
    init(router: Router, emptyCurrenciesRateModuleFactory: EmptyCurrenciesRateModuleFactory, finishFlow: EmptyCallback?) {
        self.router = router
        self.emptyCurrenciesRateModuleFactory = emptyCurrenciesRateModuleFactory
        self.finishFlow = finishFlow
    }
    
    override func start() {
        super.start()

        if self.storage.currencies.isEmpty {
            let emptyModule = self.emptyCurrenciesRateModuleFactory.makeEmptyCurrenciesRateModule()
            emptyModule.configureModule { [weak self] in
                self?.finishFlow?()
            }
            self.router.setRootModule(emptyModule)
        } else {
            // TODO: Set module
        }
    }
}
