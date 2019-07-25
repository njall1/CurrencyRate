//
//  AppDelegate+Coordinator.swift
//  CurrencyRate
//
//  Created by v.rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

extension AppDelegate {
    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }
    
    func makeCoordinator() -> Coordinator {
        return ApplicationCoordinator(router: AppRouter(rootController: self.rootController),
                                      coordinatorFactory: CoordinatorFactoryImplementation())
    }
}
