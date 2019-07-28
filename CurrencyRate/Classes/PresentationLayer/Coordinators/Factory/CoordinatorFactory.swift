//
//  CoordinatorFactory.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

protocol CoordinatorFactory {
    func makeApplicationCoordinator(rootController: UINavigationController) -> Coordinatable
    func makeAddCurrencyPair(router: Routable) -> Coordinatable & Finishable
}
