//
//  NetworkServiceProvider.swift
//  CurrencyRate
//
//  Created by v.rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

public final class NetworkServicesProvider {
    
    public static let sharedInstance = NetworkServicesProvider()
    
    private init() { }
    
    private lazy var services: [String: Any] = [:]
    
    func registerService<T>(service: T) {
        let key = "\(T.self)"
        services[key] = service
    }
    
    func tryGetService<T>() -> T? {
        let key = "\(T.self)"
        return services[key] as? T
    }
    
    func getService<T>() -> T {
        let key = "\(T.self)"
        return services[key] as! T
    }
    
    public func removeAll() {
        services.removeAll()
    }
}
