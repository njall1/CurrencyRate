//
//  CurrenciesModuleIO.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CurrenciesModuleInput {
    func configureModule(disabledCurrencies: [String], completionHandler: @escaping (_ code: String) -> Void)
}

protocol CurrenciesModuleOutput { }
