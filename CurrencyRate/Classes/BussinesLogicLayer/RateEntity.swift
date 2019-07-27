//
//  PairEntity.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

struct RateEntity: Codable {
    let pair: PairEntity
    let code: String
    let value: Double
}
