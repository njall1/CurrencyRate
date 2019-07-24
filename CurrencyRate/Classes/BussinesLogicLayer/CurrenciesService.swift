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

fileprivate let currencies: [String:String] = [ "AUD": "",
                                                "BGN": "",
                                                "BRL": "",
                                                "CAD": "",
                                                "CHF": "",
                                                "CNY": "",
                                                "CZK": "",
                                                "DKK": "Danish Krone",
                                                "EUR": "",
                                                "GBP": "Greate Britain Pound",
                                                "HKD": "",
                                                "HRK": "",
                                                "HUF": "",
                                                "IDR": "",
                                                "ILS": "",
                                                "INR": "",
                                                "ISK": "",
                                                "JPY": "",
                                                "KRW": "",
                                                "MXN": "",
                                                "MYR": "",
                                                "NOK": "",
                                                "NZD": "",
                                                "PHP": "",
                                                "PLN": "Polish Zloty",
                                                "RON": "",
                                                "RUB": "",
                                                "SEK": "Swedish Krona",
                                                "SGD": "",
                                                "THB": "",
                                                "USD": "",
                                                "ZAR": ""]
