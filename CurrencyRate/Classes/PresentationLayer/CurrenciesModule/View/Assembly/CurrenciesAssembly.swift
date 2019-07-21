//
//  CurrenciesAssembly.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

struct CurrenciesAssembly {
    static func makeCurrenciesModule() -> UIViewController? {
        guard let viewController = UIStoryboard(name: "CurrenciesStoryboard", bundle: nil).instantiateInitialViewController() as? CurrenciesViewController
            else { return nil }
        
        viewController.output = CurrenciesPresenter(view: viewController, currenciesService: CurrenciesService())
        viewController.adapter = CurrenciesAdapter()
        viewController.adapter.delegate = viewController.output as? CurrenciesAdapterDelegate
        return viewController
    }
}