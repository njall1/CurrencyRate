//
//  PairsService.swift
//  CurrencyRate
//
//  Created by v.rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol PairsServiceInput {
    func fetchPairs(pairs: [Pair], completionHandler: @escaping (Result<[PairEntity], Error>) -> Void)
}

final class PairsService: Networkable, PairsServiceInput {
    var dataTaskManager: DataTaskManagerInput = ServiceLocator.sharedInstance.getService()
    
    func fetchPairs(pairs: [Pair], completionHandler: @escaping (Result<[PairEntity], Error>) -> Void) {
        let params: [Param] = pairs.reduce(into: [Param]()) { $0.append(("pairs" ,$1.first.code + $1.secodn.code)) }
        let request = ApiRequest(path: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios", params: params)
        self.dataTaskManager.perform(request: request) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let json):
                let response = pairs.map { pair -> PairEntity in
                    let code = pair.first.code + pair.secodn.code
                    return PairEntity(pair: pair, code: code, value: json?[code] as? Double ?? 0.0)
                }
                
                completionHandler(.success(response))
            }
        }
    }
}
