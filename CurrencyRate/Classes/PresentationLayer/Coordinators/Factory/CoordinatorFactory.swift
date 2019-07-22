//
//  CoordinatorFactory.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CoordinatorFactory {
    func makeAddCurrencyPair(router: Router) -> Coordinator & Finishable
    func makeCurrencyRate(router: Router) -> Coordinator & Finishable
}
