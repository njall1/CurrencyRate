//
//  AddCurrencyPairCoordinatorHelperTests.swift
//  CurrencyRateTests
//
//  Created by Vitaliy Rusinov on 28/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import XCTest
@testable import CurrencyRate

class AddCurrencyPairCoordinatorHelperTests: XCTestCase {
    
    var sut: AddCurrencyPairCoordinatorHelperInput!

    override func setUp() {
        super.setUp()
        sut = AddCurrencyPairCoordinatorHelper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDisableCurrenciesByCurrencyMethod() {
        let currency1 = CurrencyEntity(code: "EUR", name: "")
        let currency2 = CurrencyEntity(code: "GBP", name: "")
        let currency3 = CurrencyEntity(code: "DKK", name: "")
        let pair1 = PairEntity(first:currency1, second: currency2)
        let pair2 = PairEntity(first: currency1, second: currency3)
        let pairs = [pair1, pair2]
        
        let disabledCurrencies = sut.makeDisabledCurrencies(currency: currency1, pairs: pairs)
        
        XCTAssertEqual([currency2, currency3, currency1], disabledCurrencies, "Disabled currencies from makeDisabledCurrencies(currency: CurrencyEntity, pairs: [PairEntity]) is wrong!")
    }
    
    func testDisabledCurrenciesWithAvailable() {
        let currency1 = CurrencyEntity(code: "EUR", name: "")
        let currency2 = CurrencyEntity(code: "GBP", name: "")
        let currency3 = CurrencyEntity(code: "DKK", name: "")
        let pair1 = PairEntity(first:currency1, second: currency2)
        let pair2 = PairEntity(first: currency1, second: currency3)
        let pairs = [pair1, pair2]
        let availableCurrencies = [currency1, currency2, currency3]
        
        let disabledCurrencies = sut.makeDisabledCurrenies(availableCurrencies: availableCurrencies, pairs: pairs)
        
        XCTAssertEqual([currency1], disabledCurrencies, "Disabled currencies from makeDisabledCurrencies(availableCurrencies: [CurrencyEntity], pairs: [PairEntity]) is wrong!")
    }
}
