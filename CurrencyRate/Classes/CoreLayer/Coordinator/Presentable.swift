//
//  Presentable.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 16/06/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}
