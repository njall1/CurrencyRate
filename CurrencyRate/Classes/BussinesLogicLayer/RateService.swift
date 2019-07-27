//
//  PairsService.swift
//  CurrencyRate
//
//  Created by v.rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol RateServiceInput {
    func fetchRates(pairs: [PairEntity], completionHandler: @escaping (Result<[RateEntity], Error>) -> Void)
}

final class RateService: Networkable, RateServiceInput {
    var dataTaskManager: DataTaskManagerInput = ServiceLocator.sharedInstance.getService()
    
    func fetchRates(pairs: [PairEntity], completionHandler: @escaping (Result<[RateEntity], Error>) -> Void) {
        let params: [Param] = pairs.reduce(into: [Param]()) { $0.append(("pairs" ,$1.first.code + $1.second.code)) }
        let request = ApiRequest(path: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios", params: params)
        self.dataTaskManager.perform(request: request) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let json):
                let response = pairs.map { pair -> RateEntity in
                    let code = pair.first.code + pair.second.code
                    return RateEntity(pair: pair, code: code, value: json?[code] as? Double ?? 0.0)
                }
                
                completionHandler(.success(response))
            }
        }
    }
}
