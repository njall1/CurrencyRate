//
//  AppDelegate+DI.swift
//  CurrencyRate
//
//  Created by v.rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

extension AppDelegate {    
    func registerServices() {
        let dataManager: DataManagerInput = DataManager()
        ServiceLocator.sharedInstance.registerService(service: dataManager)
        
        let storageService: StorageServiceInput = StorageService(dataManager: ServiceLocator.sharedInstance.getService())
        ServiceLocator.sharedInstance.registerService(service: storageService)
        
        let dataTaskManager: DataTaskManagerInput = DataTaskManager()
        ServiceLocator.sharedInstance.registerService(service: dataTaskManager)
        
        let pairServiceInput: PairsServiceInput = PairsService()
        ServiceLocator.sharedInstance.registerService(service: pairServiceInput)
        
        let currenciesService: CurenciesServiceInput = CurrenciesService()
        ServiceLocator.sharedInstance.registerService(service: currenciesService)
    }
}
