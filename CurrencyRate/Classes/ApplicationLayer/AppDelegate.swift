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
    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }
    
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.registerServices()
        self.applicationCoordinator.start()
        return true
    }
}

private extension AppDelegate {
    func makeCoordinator() -> Coordinator {
        return ApplicationCoordinator(router: AppRouter(rootController: self.rootController),
                                                        coordinatorFactory: CoordinatorFactoryImplementation())
    }
    
    func registerServices() {
        let pairService: PairsServiceInput = PairsService()
        NetworkServicesProvider.sharedInstance.registerService(service: pairService)
        let currenciesService: CurenciesServiceInput = CurrenciesService()
        NetworkServicesProvider.sharedInstance.registerService(service: currenciesService)
    }
}
