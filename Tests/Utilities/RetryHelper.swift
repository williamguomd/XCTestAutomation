//
//  RetryHelper.swift
//  XCTestAutomation
//
//  Helper class for retrying flaky operations
//

import XCTest

class RetryHelper {
    
    /// Retry an operation until it succeeds or max attempts are reached
    static func retry<T>(maxAttempts: Int = 3,
                        delay: TimeInterval = 1.0,
                        operation: () throws -> T) rethrows -> T {
        var lastError: Error?
        
        for attempt in 1...maxAttempts {
            do {
                return try operation()
            } catch {
                lastError = error
                if attempt < maxAttempts {
                    Thread.sleep(forTimeInterval: delay)
                }
            }
        }
        
        if let error = lastError {
            throw error
        }
        
        fatalError("Retry failed after \(maxAttempts) attempts")
    }
    
    /// Retry an async operation until it succeeds or max attempts are reached
    static func retryAsync<T>(maxAttempts: Int = 3,
                             delay: TimeInterval = 1.0,
                             operation: @escaping () async throws -> T) async rethrows -> T {
        var lastError: Error?
        
        for attempt in 1...maxAttempts {
            do {
                return try await operation()
            } catch {
                lastError = error
                if attempt < maxAttempts {
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                }
            }
        }
        
        if let error = lastError {
            throw error
        }
        
        fatalError("Retry failed after \(maxAttempts) attempts")
    }
    
    /// Retry until condition is met
    @discardableResult
    static func retryUntil(maxAttempts: Int = 5,
                          delay: TimeInterval = 0.5,
                          condition: () -> Bool) -> Bool {
        for attempt in 1...maxAttempts {
            if condition() {
                return true
            }
            if attempt < maxAttempts {
                Thread.sleep(forTimeInterval: delay)
            }
        }
        return false
    }
}


