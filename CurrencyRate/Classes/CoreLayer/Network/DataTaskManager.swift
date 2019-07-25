//
//  DataTaskManager.swift
//  CurrencyRate
//
//  Created by v.rusinov on 24/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

typealias Param = (String, AnyHashable)
typealias JSON = [String: AnyHashable]
typealias DataTaskCallback = (Result<JSON?, Error>) -> Void

struct AppError: Error { }

struct ApiRequest: Hashable, Equatable {
    static func == (lhs: ApiRequest, rhs: ApiRequest) -> Bool {
        return lhs.path == rhs.path
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
    
    let path: String
    let params: [Param]
}

protocol DataTaskManagerInput {
    @discardableResult func perform(request: ApiRequest, completionHandler: @escaping DataTaskCallback) -> URLSessionDataTask?
}

final class DataTaskManager: DataTaskManagerInput {
    let defaultSession = URLSession(configuration: .default)
    
    @discardableResult func perform(request: ApiRequest, completionHandler: @escaping DataTaskCallback) -> URLSessionDataTask? {
        var urlComponents = URLComponents(string: request.path)
        urlComponents?.query = self.makeQuery(params: request.params)
        
        guard let url = urlComponents?.url else {
            DispatchQueue.main.async {
                completionHandler(.failure(AppError()))
            }
            return nil
        }
        
        let dataTask = self.defaultSession.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            } else {
                guard let dataResponse = data, error == nil else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(AppError()))
                    }
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
        
        dataTask.resume()
        return dataTask
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
