//
//  AppRouter.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 16/06/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class AppRouter: Routable {
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController: EmptyCallback]
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        self.completions = [:]
    }
    
    func toPresent() -> UIViewController? {
        return self.rootController
    }
    
    func present(module: Presentable?) {
        self.present(module: module, animated: true)
    }
    
    func present(module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func push(module: Presentable?) {
        self.push(module: module, animated: true)
    }
    
    func push(module: Presentable?, hideBottomBar: Bool) {
        self.push(module: module, animated: true, hideBottomBar: hideBottomBar, completion: { })
    }
    
    func push(module: Presentable?, animated: Bool) {
        self.push(module: module, animated: animated, completion: { })
    }
    
    func push(module: Presentable?, animated: Bool, completion: EmptyCallback?) {
        self.push(module: module, animated: animated, hideBottomBar: true, completion: completion)
    }
    
    func push(module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: EmptyCallback?) {
        guard let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure(""); return }
        
        if let completion = completion {
            self.completions[controller] = completion // Think about it !
        }
        
        controller.hidesBottomBarWhenPushed = hideBottomBar
        self.rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule() {
        self.popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        if let controller = self.rootController?.popViewController(animated: animated) {
            self.runCompletion(controller: controller)
        }
    }
    
    func dismissModule() {
        self.dismissModule(animated: true, completion: { })
    }
    
    func dismissModule(animated: Bool, completion: EmptyCallback?) {
        self.rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func setRootModule(_ module: Presentable?) {
        self.setRootModule(module, hideBar: true)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.setViewControllers([controller], animated: true)
        self.rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = self.rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { [weak self] controller in
                self?.runCompletion(controller: controller)
            }
        }
    }
}

private extension AppRouter {
    func runCompletion(controller: UIViewController) {
        guard let completion = self.completions[controller] else { return }
            completion()
        self.completions.removeValue(forKey: controller)
    }
}
