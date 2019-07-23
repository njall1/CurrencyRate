//
//  PairsService.swift
//  CurrencyRate
//
//  Created by v.rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    let rates: [String: Float]?
}

struct InternetError: Error { }

protocol PairsServiceInput {
    func fetchPairs(pairs: [Pair], completionHandler: @escaping (Result<[PairEntity], Error>) -> Void)
}

final class PairsService: PairsServiceInput {
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    func fetchPairs(pairs: [Pair], completionHandler: @escaping (Result<[PairEntity], Error>) -> Void) {
        self.dataTask?.cancel()
        
        let query = pairs.map { "pairs=" + $0.0.code + $0.1.code }.joined(separator:"&")
        
        var urlComponents = URLComponents(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios")
        urlComponents?.query = query
        
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
                guard let dataResponse = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return }
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as? [String: Double]
                    
                    let response = pairs.map { pair -> PairEntity in
                        let code = pair.0.code + pair.1.code
                        return PairEntity(pair: pair, code: code, value: jsonResponse?[code] ?? 0.0)
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(.success(response))
                    }
                } catch let parsingError {
                    DispatchQueue.main.async {
                        completionHandler(.failure(parsingError))
                    }
                }
            }
        }
        
        self.dataTask?.resume()
    }
}
