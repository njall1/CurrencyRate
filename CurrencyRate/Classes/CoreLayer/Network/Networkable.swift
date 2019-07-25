//
//  CommonNetworkService.swift
//  CurrencyRate
//
//  Created by v.rusinov on 24/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol Networkable {
    var dataTaskManager: DataTaskManagerInput { get set }
}

