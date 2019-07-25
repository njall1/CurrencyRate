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
            let encodedData = try PropertyListEncoder().encode(pairs)
            self.dataManager.addNewEntryToStorage(DataManager.Keys.selectedPairs, value:encodedData as AnyObject)
            self.dataManager.saveStorage()
        } catch {
            fatalError("Encode issue!")
        }
    }
    
    func fetchPairsFromStorage() -> [Pair] {
        var pairs = [Pair]()
        do {
            if let data = self.dataManager.readFromStorage(DataManager.Keys.selectedPairs) as? Data {
                pairs = try PropertyListDecoder().decode([Pair].self, from: data)
            }
        } catch {
            fatalError("Decode issue!")
        }
        return pairs
    }
}
