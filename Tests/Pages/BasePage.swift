//
//  BasePage.swift
//  XCTestAutomation
//
//  Base class for Page Object Model pattern
//

import XCTest

class BasePage {
    
    let app: XCUIApplication
    let waitHelper: WaitHelper
    
    init(app: XCUIApplication) {
        self.app = app
        self.waitHelper = WaitHelper()
    }
    
    // MARK: - Common Element Interactions
    
    /// Wait for element to exist and be hittable
    func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 10.0) {
        waitHelper.waitForElement(element, timeout: timeout)
    }
    
    /// Wait for element to exist
    func waitForElementToExist(_ element: XCUIElement, timeout: TimeInterval = 10.0) {
        waitHelper.waitForElementToExist(element, timeout: timeout)
    }
    
    /// Wait for element to disappear
    func waitForElementToDisappear(_ element: XCUIElement, timeout: TimeInterval = 10.0) {
        waitHelper.waitForElementToDisappear(element, timeout: timeout)
    }
    
    /// Tap element with wait
    func tapElement(_ element: XCUIElement, timeout: TimeInterval = 10.0) {
        waitForElement(element, timeout: timeout)
        element.tap()
    }
    
    /// Type text into element
    func typeText(_ text: String, into element: XCUIElement, timeout: TimeInterval = 10.0) {
        waitForElement(element, timeout: timeout)
        element.tap()
        element.clearText()
        element.typeText(text)
    }
    
    /// Clear text field
    func clearText(in element: XCUIElement, timeout: TimeInterval = 10.0) {
        waitForElement(element, timeout: timeout)
        element.tap()
        element.clearText()
    }
    
    /// Swipe element in direction
    func swipeElement(_ element: XCUIElement, direction: SwipeDirection, timeout: TimeInterval = 10.0) {
        waitForElementToExist(element, timeout: timeout)
        
        switch direction {
        case .up:
            element.swipeUp()
        case .down:
            element.swipeDown()
        case .left:
            element.swipeLeft()
        case .right:
            element.swipeRight()
        }
    }
    
    /// Scroll to element
    func scrollToElement(_ element: XCUIElement, maxScrolls: Int = 5) {
        var scrolls = 0
        while !element.exists && scrolls < maxScrolls {
            app.swipeUp()
            scrolls += 1
        }
    }
    
    /// Get element text safely
    func getText(from element: XCUIElement, timeout: TimeInterval = 10.0) -> String {
        waitForElementToExist(element, timeout: timeout)
        return element.label.isEmpty ? (element.value as? String ?? "") : element.label
    }
    
    /// Check if element exists
    func elementExists(_ element: XCUIElement, timeout: TimeInterval = 5.0) -> Bool {
        return waitHelper.waitForElementToExist(element, timeout: timeout)
    }
    
    /// Check if element is displayed
    func isElementDisplayed(_ element: XCUIElement, timeout: TimeInterval = 5.0) -> Bool {
        guard elementExists(element, timeout: timeout) else { return false }
        return element.isHittable
    }
}

// MARK: - Enums

enum SwipeDirection {
    case up
    case down
    case left
    case right
}


