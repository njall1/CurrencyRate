//
//  CurrenciesRateModuleIO.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

typealias RowCallback = (_ row: Int) -> Void
typealias DisabledCurrenciesCallback = (_ currencies: Int) -> Void

protocol CurrenciesRateModuleInput: Presentable, Finishable {
    var deletedPair: RowCallback? { get set }
}
