//
//  Router.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 16/06/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

protocol Router: Presentable {
    func present(module: Presentable?)
    func present(module: Presentable?, animated: Bool)
    
    func push(module: Presentable?)
    func push(module: Presentable?, hideBottomBar: Bool)
    func push(module: Presentable?, animated: Bool)
    func push(module: Presentable?, animated: Bool, completion: EmptyCallback?)
    func push(module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: EmptyCallback?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: EmptyCallback?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}
