//
//  PairEntity.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

struct RateEntity {
    let pair: PairEntity
    let code: String
    let value: Double
}

extension RateEntity: Mapperable {
    static func makeEntities(data: Data) -> [RateEntity]? {
        guard let rateDictionary: [String: Double] = try? JSONDecoder().decode(Rate.self, from: data).pairs else { return nil }
        return rateDictionary.compactMap { pair in
            var rateEntity: RateEntity?
            if let pair1 = PairEntity(string: pair.key) {
                rateEntity = RateEntity(pair: pair1, code: pair.key, value: pair.value)
            }
            return rateEntity
        }
    }
}

private struct Rate: Codable {
    var pairs: [String: Double]
    
    struct CustomCodingKeys: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
        pairs = [:]
        for key in container.allKeys {
            if let key = CustomCodingKeys(stringValue: key.stringValue) {
                let value = try container.decode(Double.self, forKey: key)
                pairs[key.stringValue] = value
            }
        }
    }
}
