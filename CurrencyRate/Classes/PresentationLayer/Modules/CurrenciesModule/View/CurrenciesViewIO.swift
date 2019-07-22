//
//  CurrenciesViewIO.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CurrenciesViewInput: AnyObject {
    func showCurrencies(_ list: [CurrencyTableViewCell.DisplayItem])
}

protocol CurrenciesViewOutput: AnyObject {
    func viewDidLoad()
}
