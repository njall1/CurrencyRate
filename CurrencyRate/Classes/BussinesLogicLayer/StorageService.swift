//
//  StorageService.swift
//  CurrencyRate
//
//  Created by v.rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol StorageServiceInput {
    func savePairsToStorage(_ pairs: [Pair])
    func fetchPairsFromStorage() -> [Pair]
}

final class StorageService: StorageServiceInput {
    let dataManager: DataManagerInput
    
    init(dataManager: DataManagerInput) {
        self.dataManager = dataManager
    }
    
    func savePairsToStorage(_ pairs: [Pair]) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: pairs, requiringSecureCoding: false)
            self.dataManager.addNewEntryToStorage(DataManager.Keys.selectedPairs, value:encodedData as AnyObject)
            self.dataManager.saveStorage()
        } catch {
            print("Save error")
        }
    }
    
    func fetchPairsFromStorage() -> [Pair] {
        var pairs = [Pair]()
        do {
            if let data = self.dataManager.readFromStorage(DataManager.Keys.selectedPairs) as? Data {
                pairs = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Pair] ?? []
            }
        } catch {
            print("Read error")
        }
        return pairs
    }
}
