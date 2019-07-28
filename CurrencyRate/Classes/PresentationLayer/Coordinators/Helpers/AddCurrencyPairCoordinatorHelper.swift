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
        let pairCurrencies = pairs.map { $0.first }
        let currencies = availableCurrencies.filter { pairCurrencies.contains($0) }
        let disabledList = currencies.filter { currency in
            var selectedCurrencies = pairs.filter { $0.first.code == currency.code }.map { $0.second }
            selectedCurrencies.append(currency)
            let isDisabledCurrency = availableCurrencies.filter { !selectedCurrencies.contains($0) }.isEmpty
            return isDisabledCurrency && selectedCurrencies.count == availableCurrencies.count
        }
        
        return disabledList
    }
    
    func makeDisabledCurrencies(currency: CurrencyEntity, pairs: [PairEntity]) -> [CurrencyEntity] {
        return pairs.filter { $0.first == currency }.map { $0.second } + [currency]
    }
}
