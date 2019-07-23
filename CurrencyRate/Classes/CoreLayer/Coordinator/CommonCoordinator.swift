//
//  CommonCoordinator.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 16/06/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

class CommonCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    // Please override start
    func start() {}
    
    func runFlow(coordinator: Coordinator & Finishable, opening: @escaping EmptyCallback) {
        coordinator.finishFlow = {
            opening()
            self.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
    }
}

private extension CommonCoordinator {
    func addDependency(_ coordinator: Coordinator) {
        guard !self.childCoordinators.contains(where: { $0 === coordinator }) else { return }
        self.childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard !self.childCoordinators.isEmpty,
            let coordinator = coordinator
            else { return }
        
        if let coordinator = coordinator as? CommonCoordinator,
            !coordinator.childCoordinators.isEmpty {
            
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }
        
        for (index, element) in self.childCoordinators.enumerated() where element === coordinator {
            self.childCoordinators.remove(at: index)
            break
        }
    }
}
