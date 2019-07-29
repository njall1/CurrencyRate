//
//  Constants.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

struct Constants {
    static let disabledAlpha: CGFloat = 0.3
    static let normalAlpha: CGFloat = 1.0
    static let pairsToUpdateTime: TimeInterval = 1.0
    static let mainFont: UIFont = UIFont.boldSystemFont(ofSize: 20)
    static let additionalFont: UIFont = UIFont.systemFont(ofSize: 15)
    static let currencies = currenciesDictionary.map { CurrencyEntity(code: $0.key, name: $0.value) }
}

fileprivate let currenciesDictionary: [String: String] = [   "AUD": "Australian Dollar",
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
