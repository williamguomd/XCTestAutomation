//
//  Logger.swift
//  XCTestAutomation
//
//  Utility class for logging test execution
//

import XCTest
import os.log

class Logger {
    
    private weak var testCase: XCTestCase?
    private let logCategory = "XCTestAutomation"
    private let osLogger: OSLog
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
        self.osLogger = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "com.xctest.automation", category: logCategory)
    }
    
    /// Log info message
    func log(_ message: String, level: LogLevel = .info) {
        let timestamp = DateFormatter().apply {
            $0.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        }.string(from: Date())
        
        let logMessage = "[\(timestamp)] [\(level.rawValue)] \(message)"
        
        // Print to console
        print(logMessage)
        
        // Log to system logger
        os_log("%{public}@", log: osLogger, type: level.osLogType, logMessage)
        
        // Add as test attachment for Xcode
        if let testCase = testCase {
            let attachment = XCTAttachment(string: logMessage)
            attachment.name = "log_\(timestamp)"
            attachment.lifetime = .keepAlways
            testCase.add(attachment)
        }
    }
    
    /// Log error message
    func error(_ message: String) {
        log(message, level: .error)
    }
    
    /// Log warning message
    func warning(_ message: String) {
        log(message, level: .warning)
    }
    
    /// Log debug message
    func debug(_ message: String) {
        log(message, level: .debug)
    }
}

// MARK: - Enums

enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
    
    var osLogType: OSLogType {
        switch self {
        case .debug:
            return .debug
        case .info:
            return .info
        case .warning:
            return .default
        case .error:
            return .error
        }
    }
}

// MARK: - Helper Extension

extension DateFormatter {
    func apply(_ block: (DateFormatter) -> Void) -> DateFormatter {
        block(self)
        return self
    }
}


