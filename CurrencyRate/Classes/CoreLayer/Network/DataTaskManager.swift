//
//  DataTaskManager.swift
//  CurrencyRate
//
//  Created by v.rusinov on 24/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

struct AppError: Error { }

struct ApiRequest {
    let path: String
    let params: [(String, AnyHashable)]
}

protocol DataTaskManagerInput {
    func perform(request: ApiRequest, completionHandler: @escaping DataTaskCallback)
}

final class DataTaskManager: DataTaskManagerInput {
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    func perform(request: ApiRequest, completionHandler: @escaping DataTaskCallback) {
        self.dataTask?.cancel()

        var urlComponents = URLComponents(string: request.path)
        urlComponents?.query = self.makeQuery(params: request.params)
        
        guard let url = urlComponents?.url else { completionHandler(.failure(AppError())); return }
        
        self.dataTask = self.defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            } else {
                guard let dataResponse = data, error == nil else {
                    completionHandler(.failure(AppError()))
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        dataResponse, options: []) as? JSON
                    
                    DispatchQueue.main.async {
                        completionHandler(.success(jsonResponse))
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

private extension DataTaskManager {
    func makeQuery(params: [(String, AnyHashable)]) -> String {
        var query = String()
        params.forEach { item in
            query += "\(item.0)=\(item.1)&"
        }
        query = String(query.dropLast())
        return query
    }
 }
