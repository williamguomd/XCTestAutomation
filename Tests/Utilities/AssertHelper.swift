//
//  AssertHelper.swift
//  XCTestAutomation
//
//  Helper class for custom assertions
//

import XCTest

class AssertHelper {
    
    /// Assert that element exists
    static func assertElementExists(_ element: XCUIElement, 
                                   message: String = "Element should exist",
                                   timeout: TimeInterval = 10.0) {
        let exists = element.waitForExistence(timeout: timeout)
        XCTAssertTrue(exists, message)
    }
    
    /// Assert that element does not exist
    static func assertElementDoesNotExist(_ element: XCUIElement,
                                         message: String = "Element should not exist",
                                         timeout: TimeInterval = 5.0) {
        let exists = element.waitForExistence(timeout: timeout)
        XCTAssertFalse(exists, message)
    }
    
    /// Assert that element is displayed (exists and is hittable)
    static func assertElementIsDisplayed(_ element: XCUIElement,
                                        message: String = "Element should be displayed",
                                        timeout: TimeInterval = 10.0) {
        let exists = element.waitForExistence(timeout: timeout)
        XCTAssertTrue(exists, message)
        
        if exists {
            XCTAssertTrue(element.isHittable, "Element should be hittable")
        }
    }
    
    /// Assert that element text equals expected value
    static func assertElementText(_ element: XCUIElement,
                                 equals expectedText: String,
                                 message: String? = nil,
                                 timeout: TimeInterval = 10.0) {
        let exists = element.waitForExistence(timeout: timeout)
        XCTAssertTrue(exists, "Element should exist to check text")
        
        if exists {
            let actualText = element.label.isEmpty ? (element.value as? String ?? "") : element.label
            let errorMessage = message ?? "Element text should equal '\(expectedText)' but was '\(actualText)'"
            XCTAssertEqual(actualText, expectedText, errorMessage)
        }
    }
    
    /// Assert that element text contains substring
    static func assertElementTextContains(_ element: XCUIElement,
                                         contains substring: String,
                                         message: String? = nil,
                                         timeout: TimeInterval = 10.0) {
        let exists = element.waitForExistence(timeout: timeout)
        XCTAssertTrue(exists, "Element should exist to check text")
        
        if exists {
            let actualText = element.label.isEmpty ? (element.value as? String ?? "") : element.label
            let errorMessage = message ?? "Element text should contain '\(substring)' but was '\(actualText)'"
            XCTAssertTrue(actualText.contains(substring), errorMessage)
        }
    }
    
    /// Assert that element is enabled
    static func assertElementIsEnabled(_ element: XCUIElement,
                                      message: String = "Element should be enabled",
                                      timeout: TimeInterval = 10.0) {
        let exists = element.waitForExistence(timeout: timeout)
        XCTAssertTrue(exists, "Element should exist to check if enabled")
        
        if exists {
            XCTAssertTrue(element.isEnabled, message)
        }
    }
    
    /// Assert that element is disabled
    static func assertElementIsDisabled(_ element: XCUIElement,
                                       message: String = "Element should be disabled",
                                       timeout: TimeInterval = 10.0) {
        let exists = element.waitForExistence(timeout: timeout)
        XCTAssertTrue(exists, "Element should exist to check if disabled")
        
        if exists {
            XCTAssertFalse(element.isEnabled, message)
        }
    }
}


