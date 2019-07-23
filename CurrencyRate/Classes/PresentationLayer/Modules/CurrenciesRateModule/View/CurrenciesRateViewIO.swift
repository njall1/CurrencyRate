//
//  CurrenciesRateViewIO.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CurrenciesRateViewInput: AnyObject {
    func showPairs(_ list: [PairTableViewCell.DisplayItem])
}

protocol CurrenciesRateViewOutput: AnyObject {
    func viewDidLoad()
    func userDidClickAddPair()
}
