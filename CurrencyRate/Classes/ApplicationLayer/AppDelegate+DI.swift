//
//  AppDelegate+DI.swift
//  CurrencyRate
//
//  Created by v.rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

extension AppDelegate {    
    func registerDI() {
        self.coordinatorFactory = CoordinatorFactoryImplementation()
        self.applicationCoordinator = self.coordinatorFactory.makeApplicationCoordinator(rootController: self.rootController)
        
        let storageService: PairsStorageServiceInput = StorageService(dataManager: DataManager())
        ServiceLocator.sharedInstance.registerService(service: storageService)
        
        let dataTaskManager: DataTaskManagerInput = DataTaskManager()
        ServiceLocator.sharedInstance.registerService(service: dataTaskManager)
        
        let pairServiceInput: RateServiceInput = RateService(dataTaskManager: DataTaskManager())
        ServiceLocator.sharedInstance.registerService(service: pairServiceInput)
    }
}
