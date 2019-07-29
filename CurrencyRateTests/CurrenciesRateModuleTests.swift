//
//  CurrenciesRateModuleTests.swift
//  CurrencyRateTests
//
//  Created by Vitaliy Rusinov on 28/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import XCTest
@testable import CurrencyRate

class CurrenciesRateModuleTests: XCTestCase {

    var storage: PairsStorageServiceInput!
    var service: RateServiceInput!
    
    override func setUp() {
        super.setUp()
        storage = StorageService(dataManager: DataManager())
        service = RateService(dataTaskManager: DataTaskManager())
    }

    override func tearDown() {
        storage = nil
        service = nil
        super.tearDown()
    }

    func testmoduleAssembly() {
        let module = CurrenciesRateAssembly.makeCurrenciesRateModule(rateServie: service, pairsStorage: storage)
        XCTAssert(module != nil, "CurrnciesRateModule didn't assemble by CurrenciesRateAssembly!")
    }
}
