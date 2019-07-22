//
//  ModuleFactory.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class ModuleFactoryImplementation { }

extension ModuleFactoryImplementation: EmptyCurrenciesRateModuleFactory {
    func makeEmptyCurrenciesRateModule() -> EmptyCurrenciesRateModuleInput {
        guard let module = EmptyCurrenciesRateAssembly.makeEmptyCurrenciesRateModule()
            else { fatalError("DI Error for EmptyCurrenciesRateAssembly.") }
        return module
    }
}
