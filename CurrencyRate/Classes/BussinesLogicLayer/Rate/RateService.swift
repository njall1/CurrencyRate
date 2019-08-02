//
//  PairsService.swift
//  CurrencyRate
//
//  Created by v.rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol RateServiceInput {
    func fetchRates(
        pairs: [PairEntity],
        completionHandler: @escaping (Result<[RateEntity], Error>) -> Void)
}

final class RateService: Networkable, RateServiceInput {
    var dataTaskManager: DataTaskManagerInput
    
    init(dataTaskManager: DataTaskManagerInput) {
        self.dataTaskManager = dataTaskManager
    }
    
    func fetchRates(
        pairs: [PairEntity],
        completionHandler: @escaping (Result<[RateEntity], Error>) -> Void)
    {
        let params: [Param] = pairs.reduce(into: [Param]()) { $0.append(("pairs" ,$1.first.code + $1.second.code)) }
        let request = ApiRequest(path: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios", params: params)
        self.dataTaskManager.perform(request: request) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                guard let data = data,
                    let rateList = RateEntity.makeEntities(data: data)
                    else {
                        completionHandler(.failure(AppError()))
                        return
                    }
                
                let sortedRates = rateList.sorted(by: { (first, second) -> Bool in
                    return first.code < second.code
                })
                
                completionHandler(.success(sortedRates))
            }
        }
    }
}
