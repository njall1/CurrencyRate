//
//  AddRateViewIO.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol AddRateViewInput: AnyObject {
    func showCurrencies(_ list: [AddRateTableViewCell.DisplayItem])
}

protocol AddRateViewOutput: AnyObject {
    func viewDidLoad()
}
