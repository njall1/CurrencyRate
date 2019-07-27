//
//  AddCurrencyPairCoordinatorHelper.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 28/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol AddCurrencyPairCoordinatorHelperInput {
    func makeDisabledCurrenies(availableCurrencies: [CurrencyEntity], pairs: [PairEntity]) -> [CurrencyEntity]
    func makeDisabledCurrencies(currency: CurrencyEntity, pairs: [PairEntity]) -> [CurrencyEntity]
}

final class AddCurrencyPairCoordinatorHelper: AddCurrencyPairCoordinatorHelperInput {
    func makeDisabledCurrenies(availableCurrencies: [CurrencyEntity], pairs: [PairEntity]) -> [CurrencyEntity] {
        var disabledList = [CurrencyEntity]()
        pairs.forEach { pair in
            var allSelected = pairs.filter { $0.first.code == pair.first.code }.map { $0.second }
            allSelected.append(pair.first)
            
            let disabledCurrency = availableCurrencies.filter { !allSelected.contains($0) }.isEmpty
            if disabledCurrency, allSelected.count == availableCurrencies.count {
                disabledList.append(pair.first)
            }
        }
        
        return disabledList
    }
    
    func makeDisabledCurrencies(currency: CurrencyEntity, pairs: [PairEntity]) -> [CurrencyEntity] {
        return pairs.filter { $0.first == currency }.map { $0.second } + [currency]
    }
}
