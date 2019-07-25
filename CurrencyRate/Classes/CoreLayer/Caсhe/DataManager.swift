//
//  CacheManager.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol DataManagerInput {
    func readFromStorage(_ key: String) -> AnyObject?
    func deleteFromStorage(_ key: String)
    func removeAll()
    func addNewEntryToStorage(_ key: String, value: AnyObject)
    func saveStorage()
}

final class DataManager: DataManagerInput {
    struct Keys {
        static let selectedPairs = "SelectedPairsKey"
    }
    
    private let storage = UserDefaults.standard
    
    func readFromStorage(_ key: String) -> AnyObject? {
        return self.storage.value(forKey: key) as AnyObject?
    }
    
    func deleteFromStorage(_ key: String) {
        self.storage.removeObject(forKey: key)
    }
    
    func addNewEntryToStorage(_ key: String, value: AnyObject) {
        self.storage.set(value, forKey: key)
    }
    
    func saveStorage() {
        self.storage.synchronize()
    }
    
    func removeAll() {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
        self.storage.removePersistentDomain(forName: bundleIdentifier)
    }
}
