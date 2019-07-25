//
//  PairEntity.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

struct Pair: Codable {
    let first: CurrencyEntity
    let secodn: CurrencyEntity
}

struct PairEntity: Codable {
    let pair: Pair
    let code: String
    let value: Double
}
