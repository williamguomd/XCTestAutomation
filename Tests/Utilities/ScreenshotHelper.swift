//
//  ScreenshotHelper.swift
//  XCTestAutomation
//
//  Utility class for taking screenshots during test execution
//

import XCTest

class ScreenshotHelper {
    
    private weak var testCase: XCTestCase?
    private let screenshotDirectory: String
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
        
        // Create screenshots directory
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        screenshotDirectory = documentsPath.appendingPathComponent("Screenshots").path
        
        createScreenshotDirectoryIfNeeded()
    }
    
    /// Create screenshot directory if it doesn't exist
    private func createScreenshotDirectoryIfNeeded() {
        if !FileManager.default.fileExists(atPath: screenshotDirectory) {
            try? FileManager.default.createDirectory(
                atPath: screenshotDirectory,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
    }
    
    /// Take a screenshot with optional name
    func takeScreenshot(name: String? = nil) {
        guard let testCase = testCase else { return }
        
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        
        // Generate filename
        let timestamp = DateFormatter().apply {
            $0.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        }.string(from: Date())
        
        let filename = name != nil ? "\(name!)_\(timestamp).png" : "screenshot_\(timestamp).png"
        attachment.name = filename
        attachment.lifetime = .keepAlways
        
        testCase.add(attachment)
    }
    
    /// Take screenshot of specific element
    func takeScreenshot(of element: XCUIElement, name: String? = nil) {
        guard let testCase = testCase else { return }
        
        let screenshot = element.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        
        let timestamp = DateFormatter().apply {
            $0.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        }.string(from: Date())
        
        let filename = name != nil ? "\(name!)_\(timestamp).png" : "element_screenshot_\(timestamp).png"
        attachment.name = filename
        attachment.lifetime = .keepAlways
        
        testCase.add(attachment)
    }
}

// MARK: - Helper Extension

extension DateFormatter {
    func apply(_ block: (DateFormatter) -> Void) -> DateFormatter {
        block(self)
        return self
    }
}


