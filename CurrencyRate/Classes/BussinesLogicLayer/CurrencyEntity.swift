//
//  CurrencyEntity.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

struct CurrencyEntity {
    let code: String
    let name: String
}

extension CurrencyEntity: Equatable {}

extension CurrencyEntity {
    init?(code: String) {
        guard let currency = Constants.currencies.first(where: { $0.code == code }) else { return nil }
        
        self.code = currency.code
        self.name = currency.name
    }
}
