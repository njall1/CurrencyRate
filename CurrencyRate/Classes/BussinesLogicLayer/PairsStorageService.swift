//
//  StorageService.swift
//  CurrencyRate
//
//  Created by v.rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol PairsStorageServiceInput {
    func savePairsToStorage(_ pairs: [Pair])
    func fetchPairsFromStorage() -> [Pair]
}

final class PairsStorageService: PairsStorageServiceInput {
    let dataManager: DataManagerInput
    
    init() {
        self.dataManager = ServiceLocator.sharedInstance.getService()
    }
    
    func savePairsToStorage(_ pairs: [Pair]) {
        do {
            self.dataManager.deleteFromStorage(DataManager.Keys.selectedPairs)
            let encodedData = try PropertyListEncoder().encode(pairs)
            self.dataManager.addNewEntryToStorage(DataManager.Keys.selectedPairs, value:encodedData as AnyObject)
            self.dataManager.saveStorage()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchPairsFromStorage() -> [Pair] {
        var pairs = [Pair]()
        do {
            if let data = self.dataManager.readFromStorage(DataManager.Keys.selectedPairs) as? Data {
                pairs = try PropertyListDecoder().decode([Pair].self, from: data)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return pairs
    }
}
