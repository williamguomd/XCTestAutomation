//
//  TestConfig.swift
//  XCTestAutomation
//
//  Configuration management for test execution
//

import Foundation

class TestConfig {
    
    static let shared = TestConfig()
    
    // MARK: - App Configuration
    
    /// App bundle identifier
    var appBundleIdentifier: String {
        // Update this with your app's bundle identifier
        return "com.example.YourApp"
    }
    
    /// Launch arguments for the app
    var launchArguments: [String] {
        var args: [String] = []
        
        // Add environment-specific arguments
        if isUITesting {
            args.append("-UITesting")
        }
        
        // Add any other launch arguments
        // args.append("-ResetData")
        
        return args
    }
    
    /// Check if running in UI testing mode
    var isUITesting: Bool {
        return ProcessInfo.processInfo.arguments.contains("-UITesting")
    }
    
    // MARK: - Timeout Configuration
    
    /// Default timeout for element waits
    var defaultTimeout: TimeInterval = 10.0
    
    /// Short timeout for quick checks
    var shortTimeout: TimeInterval = 5.0
    
    /// Long timeout for slow operations
    var longTimeout: TimeInterval = 30.0
    
    // MARK: - Environment Configuration
    
    /// Current environment
    var environment: Environment = .staging
    
    /// Base URL for API calls (if needed)
    var baseURL: String {
        switch environment {
        case .development:
            return "https://dev-api.example.com"
        case .staging:
            return "https://staging-api.example.com"
        case .production:
            return "https://api.example.com"
        }
    }
    
    // MARK: - Test Configuration
    
    /// Take screenshots on test failure
    var takeScreenshotsOnFailure: Bool = true
    
    /// Take screenshots on test success (for debugging)
    var takeScreenshotsOnSuccess: Bool = false
    
    /// Maximum retry attempts for flaky tests
    var maxRetryAttempts: Int = 2
    
    private init() {
        loadConfiguration()
    }
    
    /// Load configuration from environment or defaults
    private func loadConfiguration() {
        // You can load from environment variables, plist files, etc.
        if let env = ProcessInfo.processInfo.environment["TEST_ENVIRONMENT"] {
            switch env.lowercased() {
            case "dev", "development":
                environment = .development
            case "prod", "production":
                environment = .production
            default:
                environment = .staging
            }
        }
    }
}

// MARK: - Enums

enum Environment: String {
    case development = "Development"
    case staging = "Staging"
    case production = "Production"
}


