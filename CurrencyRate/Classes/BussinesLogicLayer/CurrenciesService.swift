//
//  CurrenciesService.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CurenciesServiceInput {
    func fetchCurencies(completionHandler: @escaping (Result<[CurrencyEntity], Error>) -> Void)
}

final class CurrenciesService: CurenciesServiceInput {
    func fetchCurencies(completionHandler: @escaping (Result<[CurrencyEntity], Error>) -> Void) {
        let currencyEntities = currencies.map { CurrencyEntity(code: $0.key, name: $0.value) }
        completionHandler(.success(currencyEntities))
    }
}

fileprivate let currencies: [String:String] = [ "AUD": "Australian Dollar",
                                                "BGN": "Some Currency",
                                                "BRL": "Some Currency",
                                                "CAD": "Some Currency",
                                                "CHF": "Some Currency",
                                                "CNY": "Some Currency",
                                                "CZK": "Czech Koruna",
                                                "DKK": "Danish Krone",
                                                "EUR": "Euro",
                                                "GBP": "Greate Britain Pound",
                                                "HKD": "Hong Kong Dollar",
                                                "HRK": "Some Currency",
                                                "HUF": "Hungarian Forint",
                                                "IDR": "Some Currency",
                                                "ILS": "Some Currency",
                                                "INR": "Some Currency",
                                                "ISK": "Some Currency",
                                                "JPY": "Some Currency",
                                                "KRW": "Some Currency",
                                                "MXN": "Some Currency",
                                                "MYR": "Some Currency",
                                                "NOK": "Norwegian Krone",
                                                "NZD": "Some Currency",
                                                "PHP": "Some Currency",
                                                "PLN": "Polish Zloty",
                                                "RON": "Some Currency",
                                                "RUB": "Some Currency",
                                                "SEK": "Swedish Krona",
                                                "SGD": "Singapore Dollar",
                                                "THB": "Some Currency",
                                                "USD": "United States Dollar",
                                                "ZAR": "Some Currency"]
