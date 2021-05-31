//
//  Debouncer.swift
//  MovieFinder
//
//  Created by apple on 02/04/21.
//

import Foundation

final class Debouncer {
    
    private let delay: TimeInterval
    private var timer: Timer?
    
    typealias Handler = () -> Void
    private var handler: Handler?
    
    init(delay: TimeInterval, handler: @escaping Handler) {
        self.delay = delay
        self.handler = handler
    }
    
    public func debounce() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { [weak self] (timer) in
            self?.timeIntervalDidFinish(for: timer)
        })
    }
    
    @objc private func timeIntervalDidFinish(for timer: Timer) {
        guard timer.isValid else {
            return
        }
        handler?()
    }
}
