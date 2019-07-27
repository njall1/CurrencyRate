//
//  DeferedAction.swift
//  CurrencyRate
//
//  Created by v.rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

public class DeferredAction {
    public let deferTime: TimeInterval
    public let action: (() -> Void)?
    
    private var timer: Timer?
    
    public init(deferTime: TimeInterval = 1, action: (() -> Void)? = nil) {
        let safeDeferTime = deferTime > 0 ? deferTime : 1
        self.deferTime = safeDeferTime
        self.action = action
    }
    
    public func `defer`() {
        self.startTimer()
    }
    
    public func cancel() {
        self.invalidateTimer()
    }
    
    public func run() {
        self.performAction()
    }
    
    private func startTimer() {
        self.invalidateTimer()
        self.timer = Timer.scheduledTimer(timeInterval: self.deferTime,
                                          target: self,
                                          selector: #selector(performAction),
                                          userInfo: nil,
                                          repeats: false)
    }
    
    @objc fileprivate func performAction() {
        self.invalidateTimer()
        action?()
    }
    
    private func invalidateTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    deinit {
        self.invalidateTimer()
    }
    
}
