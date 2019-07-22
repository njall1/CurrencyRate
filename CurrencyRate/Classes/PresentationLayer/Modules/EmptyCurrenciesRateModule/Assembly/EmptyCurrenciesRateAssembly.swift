//
//  EmptyCurrenciesRateAssembly.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

struct EmptyCurrenciesRateAssembly {
    static func makeEmptyCurrenciesRateModule() -> EmptyCurrenciesRateModuleInput? {
        guard let viewController = UIStoryboard(name: "EmptyCurrenciesRateStoryboard", bundle: nil).instantiateInitialViewController() as? EmptyCurrenciesRateViewController
            else { return nil }
        
        viewController.output = EmptyCurrenciesRatePresenter(view: viewController)
        return viewController.output as? EmptyCurrenciesRateModuleInput
    }
}
