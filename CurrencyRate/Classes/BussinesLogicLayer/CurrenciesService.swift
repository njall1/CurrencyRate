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
        let currencyEntities = currencies.map { CurrencyEntity(code: $0) }
        completionHandler(.success(currencyEntities))
    }
}

fileprivate let currencies: [String] = [    "AUD",
                                            "BGN",
                                            "BRL",
                                            "CAD",
                                            "CHF",
                                            "CNY",
                                            "CZK",
                                            "DKK",
                                            "EUR",
                                            "GBP",
                                            "HKD",
                                            "HRK",
                                            "HUF",
                                            "IDR",
                                            "ILS",
                                            "INR",
                                            "ISK",
                                            "JPY",
                                            "KRW",
                                            "MXN",
                                            "MYR",
                                            "NOK",
                                            "NZD",
                                            "PHP",
                                            "PLN",
                                            "RON",
                                            "RUB",
                                            "SEK",
                                            "SGD",
                                            "THB",
                                            "USD",
                                            "ZAR"]
