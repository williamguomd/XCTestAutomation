//
//  WaitHelper.swift
//  XCTestAutomation
//
//  Utility class for waiting on UI elements
//

import XCTest

class WaitHelper {
    
    /// Wait for element to exist and be hittable
    func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 10.0) {
        let predicate = NSPredicate(format: "exists == true AND hittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        
        if result != .completed {
            XCTFail("Element \(element.description) did not become available within \(timeout) seconds")
        }
    }
    
    /// Wait for element to exist (doesn't need to be hittable)
    @discardableResult
    func waitForElementToExist(_ element: XCUIElement, timeout: TimeInterval = 10.0) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
    
    /// Wait for element to disappear
    @discardableResult
    func waitForElementToDisappear(_ element: XCUIElement, timeout: TimeInterval = 10.0) -> Bool {
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
    
    /// Wait for element to have specific value
    func waitForElementValue(_ element: XCUIElement, value: String, timeout: TimeInterval = 10.0) {
        let predicate = NSPredicate(format: "value == %@", value)
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        
        if result != .completed {
            XCTFail("Element \(element.description) did not have value '\(value)' within \(timeout) seconds")
        }
    }
    
    /// Wait for element to be enabled
    func waitForElementToBeEnabled(_ element: XCUIElement, timeout: TimeInterval = 10.0) {
        let predicate = NSPredicate(format: "enabled == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        
        if result != .completed {
            XCTFail("Element \(element.description) did not become enabled within \(timeout) seconds")
        }
    }
    
    /// Wait for condition to be true
    @discardableResult
    func waitForCondition(_ condition: @escaping () -> Bool, timeout: TimeInterval = 10.0) -> Bool {
        let startTime = Date()
        while Date().timeIntervalSince(startTime) < timeout {
            if condition() {
                return true
            }
            Thread.sleep(forTimeInterval: 0.1)
        }
        return false
    }
}


