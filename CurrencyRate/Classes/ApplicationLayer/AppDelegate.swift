//
//  AppDelegate.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 18/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinatorFactory: CoordinatorFactory!
    var applicationCoordinator: Coordinatable! 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.registerDI()
        self.applicationCoordinator.start()
        return true
    }
}
