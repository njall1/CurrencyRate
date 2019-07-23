//
//  Coordinator.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 21/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func runFlow(coordinator: Coordinator & Finishable, opening: @escaping EmptyCallback)
}
