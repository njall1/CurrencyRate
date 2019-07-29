//
//  Mapperable.swift
//  CurrencyRate
//
//  Created by v.rusinov on 29/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol Mapperable {
    static func makeEntities(data: Data) -> [Self]?
}
