//
//  StorageService.swift
//  CurrencyRate
//
//  Created by v.rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol PairsStorageServiceInput {
    var pairs: [PairEntity] { get set }
}

final class StorageService: PairsStorageServiceInput {
    let dataManager: DataManagerInput
    
    private let concurrentPairsQueue = DispatchQueue(label: "com.njall.CurrencyRate.Pair", attributes: .concurrent)
    private var unsasfePairs = [PairEntity]()
    var pairs: [PairEntity] {
        get {
            var pairsCopy: [PairEntity]!
            self.concurrentPairsQueue.sync {
                pairsCopy = self.unsasfePairs
            }
            return pairsCopy
        }
        
        set {
            self.concurrentPairsQueue.async(flags: .barrier) { [weak self] in
                guard let self = self else { return }
                
                self.unsasfePairs = newValue
                self.savePairsToStorage(self.unsasfePairs)
            }
        }
    }
    
    init(dataManager: DataManagerInput) {
        self.dataManager = dataManager
        self.pairs = self.fetchPairsFromStorage()
    }
}

private extension StorageService {
    func savePairsToStorage(_ pairs: [PairEntity]) {
        self.dataManager.addNewEntryToStorage(DataManager.Keys.selectedPairs, value: PairEntity.makeString(pairs: pairs) as AnyObject)
        self.dataManager.saveStorage()
    }
    
    func fetchPairsFromStorage() -> [PairEntity] {
        guard let string = self.dataManager.readFromStorage(DataManager.Keys.selectedPairs) as? String else { return [] }
        return PairEntity.makePairs(string: string)
    }
}
