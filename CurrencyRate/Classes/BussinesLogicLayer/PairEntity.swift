//
//  PairEntity.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 27/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

struct PairEntity: Codable {
    let first: CurrencyEntity
    let second: CurrencyEntity
}

extension PairEntity {
    init?(string: String) {
        guard string.count == 6,
            let first = CurrencyEntity(code: String(string.dropLast(3))),
            let second = CurrencyEntity(code: String(string.dropFirst(3)))
            else { return nil }
        
            self.first = first
            self.second = second
    }
    
    static func makePairs(string: String) -> [PairEntity] {
        let components = string.components(separatedBy: ",")
        guard !components.isEmpty else { return [] }
        return components.compactMap { PairEntity(string: $0) }
    }
    
    static func makeString(pairs: [PairEntity]) -> String {
        return pairs.map { $0.first.code + $0.second.code }.joined(separator: ",")
    }
}
