//
//  CurrenciesModuleTests.swift
//  CurrencyRateTests
//
//  Created by v.rusinov on 29/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import XCTest

@testable import CurrencyRate

class CurrenciesModuleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testmoduleAssembly() {
        let module = CurrenciesAssembly.makeCurrenciesModule(disabledCurrencies: [])
        XCTAssert(module != nil, "CurrnciesModule didn't assemble by CurrenciesAssembly!")
    }
}
