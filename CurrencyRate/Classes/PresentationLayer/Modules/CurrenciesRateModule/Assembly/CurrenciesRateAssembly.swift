//
//  CurrenciesRateAssembly.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

struct CurrenciesRateAssembly {
    static func makeCurrenciesRateModule(pair: Pair) -> CurrenciesRateModuleInput? {
        guard let viewController = UIStoryboard(name: "CurrenciesRateStoryboard", bundle: nil).instantiateInitialViewController() as? CurrenciesRateViewController
            else { return nil }
        
        viewController.adapter = PairAdapter()
        viewController.output = CurrenciesRatePresenter(view: viewController, pair: pair)
       
        return viewController.output as? CurrenciesRateModuleInput
    }
}
