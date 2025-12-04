//
//  BaseTestCase.swift
//  XCTestAutomation
//
//  Base test case class that provides common setup, teardown, and utilities
//

import XCTest

class BaseTestCase: XCTestCase {
    
    var app: XCUIApplication!
    var screenshotHelper: ScreenshotHelper!
    var logger: Logger!
    
    // MARK: - Setup & Teardown
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Initialize app
        app = XCUIApplication()
        
        // Configure launch arguments if needed
        app.launchArguments = TestConfig.shared.launchArguments
        
        // Launch the app
        app.launch()
        
        // Initialize helpers
        screenshotHelper = ScreenshotHelper(testCase: self)
        logger = Logger(testCase: self)
        
        logger.log("Test started: \(self.name)")
    }
    
    override func tearDownWithError() throws {
        // Take screenshot on failure
        if let error = testRun?.totalFailureCount, error > 0 {
            screenshotHelper.takeScreenshot(name: "failure_\(self.name)")
        }
        
        logger.log("Test finished: \(self.name)")
        
        // Terminate app
        app.terminate()
        
        try super.tearDownWithError()
    }
    
    // MARK: - Helper Methods
    
    /// Wait for app to be in idle state
    func waitForAppToBeIdle(timeout: TimeInterval = 5.0) {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: app)
        _ = XCTWaiter.wait(for: [expectation], timeout: timeout)
    }
    
    /// Navigate back if possible
    func navigateBack() {
        if app.navigationBars.buttons.element(boundBy: 0).exists {
            app.navigationBars.buttons.element(boundBy: 0).tap()
        } else if app.buttons["Back"].exists {
            app.buttons["Back"].tap()
        }
    }
    
    /// Dismiss alerts if present
    func dismissAlertIfPresent() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        if springboard.alerts.count > 0 {
            springboard.alerts.buttons.firstMatch.tap()
        }
    }
}


