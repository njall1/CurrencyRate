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
                                                "BGN": "Some country Currency",
                                                "BRL": "Some country Currency",
                                                "CAD": "Some country Currency",
                                                "CHF": "Some country Currency",
                                                "CNY": "Some country Currency",
                                                "CZK": "Czech Koruna",
                                                "DKK": "Danish Krone",
                                                "EUR": "Euro",
                                                "GBP": "Greate Britain Pound",
                                                "HKD": "Hong Kong Dollar",
                                                "HRK": "Some country Currency",
                                                "HUF": "Hungarian Forint",
                                                "IDR": "Some country Currency",
                                                "ILS": "Some country Currency",
                                                "INR": "Some country Currency",
                                                "ISK": "Some country Currency",
                                                "JPY": "Some country Currency",
                                                "KRW": "Some country Currency",
                                                "MXN": "Some country Currency",
                                                "MYR": "Some country Currency",
                                                "NOK": "Norwegian Krone",
                                                "NZD": "Some country Currency",
                                                "PHP": "Some country Currency",
                                                "PLN": "Polish Zloty",
                                                "RON": "Some country Currency",
                                                "RUB": "Some country Currency",
                                                "SEK": "Swedish Krona",
                                                "SGD": "Singapore Dollar",
                                                "THB": "Some country Currency",
                                                "USD": "United States Dollar",
                                                "ZAR": "Some country Currency"]
