//
//  Repeater.swift
//  CurrencyRate
//
//  Created by v.rusinov on 02/08/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

final class Repeater: Equatable {
    enum State: Equatable, CustomStringConvertible {
        case paused
        case running
        case executing
        case finished
        
        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case  (.paused, .paused), (running, .running), (.executing, .executing), (.finished, .finished):
                return true
            default:
                return false
            }
        }
        
        var isRunning: Bool {
            guard self == .running || self == .executing else { return false }
            return true
        }
        
        var isExecuting: Bool {
            guard case .executing = self else { return false }
            return true
        }
        
        var isFinished: Bool {
            guard case .finished = self else { return false }
            return true
        }
        
        var description: String {
            switch self {
            case .paused: return "idle/paused"
            case .finished: return "finished"
            case .running: return "running"
            case .executing: return "executing"
            }
        }
    }
    
    enum Interval {
        case nanoseconds(_: Int)
        case microseconds(_: Int)
        case milliseconds(_:Int)
        case minutes(_: Int)
        case seconds(_: Double)
        case hours(_: Int)
        case days(_: Int)
    
        var value: DispatchTimeInterval {
            switch self {
            case .nanoseconds(let value): return .nanoseconds(value)
            case .microseconds(let value): return .microseconds(value)
            case .milliseconds(let value): return .milliseconds(value)
            case .seconds(let value): return .milliseconds(Int(Double(value) * Double(1000))) // warning bad code
            case .minutes(let value): return .seconds(value * 60)
            case .hours(let value): return .seconds(value * 3600)
            case .days(let value): return .seconds(value * 86400)
            }
        }
    }
    
    enum Mode {
        case infinite
        case finite(_: Int)
        case once
        
        var isRepeating: Bool {
            switch self {
            case .once: return false
            default: return true
            }
        }
        
        var countIterations: Int? {
            switch self {
            case .finite(let counts): return counts
            default: return nil
            }
        }
        
        var isInfinite: Bool {
            guard case .infinite = self else {
                return false
            }
            return true
        }
    }
    
    typealias Observer = ((Repeater) -> Void)
    typealias ObserverToken = UInt
    
    private(set) var state: State = .paused {
        didSet {
            self.onStateChanged?(self, state)
        }
    }
    
    var onStateChanged: ((_ timer: Repeater, _ state: State) -> Void)?

    private var observers: [ObserverToken: Observer] = [:]
    
    private var nextObserverID: UInt = 0
    
    private var timer: DispatchSourceTimer?
    
    private(set) var mode: Mode
    
    private(set) var remainingIterations: Int?
    
    private var interval: Interval
    
    private var tolerance: DispatchTimeInterval
    
    private var queue: DispatchQueue?
    
    init(interval: Interval,
         mode: Mode = .infinite,
         tolerance: DispatchTimeInterval = .nanoseconds(0),
         queue: DispatchQueue? = nil,
         observer: @escaping Observer)
    {
        self.mode = mode
        self.interval = interval
        self.tolerance = tolerance
        self.remainingIterations = mode.countIterations
        self.queue = (queue ?? DispatchQueue(label: "com.timer.Repeater"))
        self.timer = configureTimer()
//        self.o
    }
    
    @discardableResult
    func observe(_ observer: @escaping Observer) -> ObserverToken {
        var (new, overflow) = self.nextObserverID.addingReportingOverflow(1)
        if overflow {
            self.nextObserverID = 0
            new = 0
        }
        self.nextObserverID = new
        self.observers[new] = observer
        return new
    }
    
    func remove(observer identifier: ObserverToken) {
        self.observers.removeValue(forKey: identifier)
    }
    
    func removeAllObservers(thenStop stopTimer: Bool = false) {
        self.observers.removeAll()
        if stopTimer {
            self.pause()
        }
    }
    
    private func configureTimer() -> DispatchSourceTimer {
        let associatedQueue = (queue ?? DispatchQueue(label: "com.timer.repeat.\(NSUUID().uuidString)"))
        let timer = DispatchSource.makeTimerSource(queue: associatedQueue)
        let repeatInterval = interval.value
        let deadline: DispatchTime = (DispatchTime.now() + repeatInterval)
        if self.mode.isRepeating {
            timer.schedule(deadline: deadline, repeating: repeatInterval, leeway: tolerance)
        } else {
            timer.schedule(deadline: deadline, repeating: tolerance)
        }
        
        timer.setEventHandler { [weak self] in
            self?.timerFired()
        }
        
        return timer
    }
    
    private func destroyTimer() {
        self.timer?.setEventHandler(handler: nil)
        self.timer?.cancel()
        
        if state == .paused || state == .finished {
            self.timer?.resume()
        }
    }
    
    @discardableResult
    class func once(
        after interval: Interval,
        tolerance: DispatchTimeInterval = .nanoseconds(0),
        queue: DispatchQueue? = nil,
        _ observer: @escaping Observer)
        -> Repeater
    {
        let timer = Repeater(interval: interval, mode: .once, tolerance: tolerance, queue: queue, observer: observer)
        timer.start()
        return timer
    }
    
    @discardableResult
    public class func every(_ interval: Interval, count: Int? = nil, tolerance: DispatchTimeInterval = .nanoseconds(0), queue: DispatchQueue? = nil, _ handler: @escaping Observer) -> Repeater {
        let mode: Mode = (count != nil ? .finite(count!) : .infinite)
        let timer = Repeater(interval: interval, mode: mode, tolerance: tolerance, queue: queue, observer: handler)
        timer.start()
        return timer
    }
    
    func fire(andPause pause: Bool = false) {
        self.timerFired()
        if pause == true {
            self.pause()
        }
    }
    
    func reset(_ interval: Interval?, restart: Bool = true) {
        if self.state.isRunning {
            self.setPause(from: self.state)
        }
        
        if let newInterval = interval {
            self.interval = newInterval
        }
        
        self.destroyTimer()
        self.timer = self.configureTimer()
        self.state = .paused
        
        if restart {
            self.timer?.resume()
            self.state = .running
        }
    }
    
    @discardableResult
    func start() -> Bool {
        guard self.state.isRunning == false else {
            return false
        }
        
        guard self.state.isFinished == true else {
            self.state = .running
            self.timer?.resume()
            return true
        }
        
        self.reset(nil, restart: true)
        return true
    }
    
    @discardableResult
    func pause() -> Bool {
        guard state != .paused && state != .finished else {
            return false
        }
        
        return self.setPause(from: self.state)
    }
    
    @discardableResult
    private func setPause(from currentState: State, to newState: State = .paused) -> Bool {
        guard self.state == currentState else {
            return false
        }
        
        self.timer?.suspend()
        self.state = newState
        
        return true
    }
    
    private func timerFired() {
        self.state = .executing
        
        if case .finite = self.mode {
            self.remainingIterations! -= 1
        }
        
        // dispatch to observers
        self.observers.values.forEach { $0(self) }
        
        // manage lifetime
        switch self.mode {
        case .once:
            // once timer's lifetime is finished after the first fire
            // you can reset it by calling `reset()` function.
            self.setPause(from: .executing, to: .finished)
        case .finite:
            // for finite intervals we decrement the left iterations count...
            if self.remainingIterations! == 0 {
                // ...if left count is zero we just pause the timer and stop
                self.setPause(from: .executing, to: .finished)
            }
        case .infinite:
            // infinite timer does nothing special on the state machine
            break
        }
    }
    
    deinit {
        self.observers.removeAll()
        self.destroyTimer()
    }
    
    static func == (lhs: Repeater, rhs: Repeater) -> Bool {
        return lhs === rhs
    }
}
