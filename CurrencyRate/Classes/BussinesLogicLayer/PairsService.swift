//
//  PairsService.swift
//  CurrencyRate
//
//  Created by v.rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

struct InternetError: Error { }

protocol PairsServiceInput {
    func fetchPairs(pairs: [Pair], completionHandler: @escaping (Result<[CurrencyEntity], Error>) -> Void)
}

final class PairsService: PairsServiceInput {
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    func fetchPairs(pairs: [Pair], completionHandler: @escaping (Result<[CurrencyEntity], Error>) -> Void) {
        self.dataTask?.cancel()
        
        var urlComponents = URLComponents(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios")
        urlComponents?.query = "pairs=USDGBP&pairs=GBPUSD"
        
        guard let url = urlComponents?.url
            else {
                completionHandler(.failure(InternetError()))
                return
            }
        
        self.dataTask = self.defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.success([]))
                }
            }
        }
        
        self.dataTask?.resume()
    }
}
