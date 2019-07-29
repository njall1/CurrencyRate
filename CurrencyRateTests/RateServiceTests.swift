//
//  RateServiceTests.swift
//  CurrencyRateTests
//
//  Created by Vitaliy Rusinov on 28/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import XCTest
@testable import CurrencyRate

class RateServiceTests: XCTestCase {
    
    var sut: RateServiceInput!

    override func setUp() {
        super.setUp()
        sut = RateService(dataTaskManager: DataTaskManager())
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testResponseForFetchRates() {
        let currency1 = CurrencyEntity(code: "EUR", name: "")
        let currency2 = CurrencyEntity(code: "GBP", name: "")
        let currency3 = CurrencyEntity(code: "DKK", name: "")
        let pair1 = PairEntity(first:currency1, second: currency2)
        let pair2 = PairEntity(first: currency1, second: currency3)
        let pairs = [pair1, pair2]
        
        sut.fetchRates(pairs: pairs) { result in
            switch result {
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            case .success(let rates):
                XCTAssertEqual(rates.count, pairs.count, "Response from fetchRates(pairs: [PairEntity] ... is wrong!")
            }
        }
    }
    
    func testCallToRatesCompleted() {
        let currency1 = CurrencyEntity(code: "EUR", name: "")
        let currency2 = CurrencyEntity(code: "GBP", name: "")
        let currency3 = CurrencyEntity(code: "DKK", name: "")
        let pair1 = PairEntity(first:currency1, second: currency2)
        let pair2 = PairEntity(first: currency1, second: currency3)
        let pairs = [pair1, pair2]
        
        var rates: [RateEntity]?
        var responseError: Error?
        
        let promise = expectation(description: "Completion handler invoked")
        
        sut.fetchRates(pairs: pairs) { result in
            switch result {
            case .failure(let error):
                responseError = error
            case .success(let result):
                rates = result
            }
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(pairs.count, rates?.count)
    }
}
