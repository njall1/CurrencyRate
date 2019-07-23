//
//  CurrenciesRateAssembly.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

struct CurrenciesRateAssembly {
    static func makeCurrenciesRateModule(pairs: [Pair]) -> CurrenciesRateModuleInput? {
        guard let viewController = UIStoryboard(name: "CurrenciesRateStoryboard", bundle: nil).instantiateInitialViewController() as? CurrenciesRateViewController
            else { return nil }
        
        let pairService: PairsServiceInput? = NetworkServicesProvider.sharedInstance.tryGetService()
        if pairService == nil {
            let pairService: PairsServiceInput = PairsService()
            NetworkServicesProvider.sharedInstance.registerService(service: pairService)
        }
        
        viewController.adapter = PairAdapter()
        viewController.output = CurrenciesRatePresenter(view: viewController,
                                                        pairs: pairs,
                                                        pairService: NetworkServicesProvider.sharedInstance.getService())
       
        return viewController.output as? CurrenciesRateModuleInput
    }
}
