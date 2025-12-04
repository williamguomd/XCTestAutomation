//
//  XCUIElement+Extensions.swift
//  XCTestAutomation
//
//  Extensions for XCUIElement to add convenience methods
//

import XCTest

extension XCUIElement {
    
    /// Clear text from text field or text view
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        
        // Tap to focus
        self.tap()
        
        // Select all and delete
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
    
    /// Check if element is visible on screen
    var isVisible: Bool {
        guard exists && !frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }
    
    /// Force tap element (useful for elements that are not hittable)
    func forceTap() {
        if isHittable {
            tap()
        } else {
            coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }
    }
    
    /// Scroll to element if not visible
    func scrollToElement(in scrollView: XCUIElement, maxScrolls: Int = 5) {
        var scrolls = 0
        while !isVisible && scrolls < maxScrolls {
            scrollView.swipeUp()
            scrolls += 1
        }
    }
    
    /// Get element's text value safely
    var safeValue: String {
        if let value = value as? String {
            return value
        }
        return label
    }
}

