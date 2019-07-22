//
//  Finishable.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol Finishable: AnyObject {
    var finishFlow: EmptyCallback? { get set }
}
