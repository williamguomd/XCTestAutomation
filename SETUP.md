# Setup Guide

This guide will help you integrate the XCTest Automation Framework into your iOS project.

## Prerequisites

- Xcode 12.0 or later
- iOS 13.0 or later
- Swift 5.0 or later
- An iOS app project with UI tests target

## Integration Steps

### 1. Add Files to Your Project

1. Open your Xcode project
2. Right-click on your test target folder
3. Select "Add Files to [YourProject]..."
4. Navigate to the XCTestAutomation directory
5. Select all the framework files:
   - `Tests/Base/`
   - `Tests/Pages/`
   - `Tests/TestCases/`
   - `Tests/Utilities/`
   - `Config/`
   - `Resources/`
6. Make sure "Copy items if needed" is checked
7. Ensure your test target is selected in "Add to targets"
8. Click "Add"

### 2. Configure Test Target

1. Select your test target in Xcode
2. Go to "Build Settings"
3. Ensure "Swift Language Version" is set to Swift 5 or later
4. In "Build Phases", verify all framework files are included

### 3. Update TestConfig.swift

1. Open `Config/TestConfig.swift`
2. Update `appBundleIdentifier` with your app's bundle identifier:
   ```swift
   var appBundleIdentifier: String {
       return "com.yourcompany.yourapp"
   }
   ```

### 4. Add Test Data

1. Ensure `Resources/TestData/testData.json` is added to your test target
2. Update the JSON file with your test data
3. Verify the file is included in "Copy Bundle Resources" in Build Phases

### 5. Configure Accessibility Identifiers

For the framework to work properly, your app's UI elements need accessibility identifiers:

**In your app code:**
```swift
// Swift
usernameTextField.accessibilityIdentifier = "usernameTextField"
passwordTextField.accessibilityIdentifier = "passwordTextField"
loginButton.accessibilityIdentifier = "loginButton"

// Objective-C
usernameTextField.accessibilityIdentifier = @"usernameTextField";
passwordTextField.accessibilityIdentifier = @"passwordTextField";
loginButton.accessibilityIdentifier = @"loginButton";
```

**Or in Interface Builder:**
1. Select the UI element
2. Open Identity Inspector
3. Set "Identifier" in the Accessibility section

### 6. Verify Setup

Create a simple test to verify everything is working:

```swift
import XCTest

class SetupVerificationTests: BaseTestCase {
    
    func testAppLaunches() {
        // This test verifies the app launches successfully
        XCTAssertTrue(app.state == .runningForeground, "App should be running")
    }
}
```

Run this test. If it passes, your setup is complete!

## Project Structure

After integration, your test target should look like this:

```
YourTestTarget/
├── Tests/
│   ├── Base/
│   │   └── BaseTestCase.swift
│   ├── Pages/
│   │   ├── BasePage.swift
│   │   └── Example/
│   │       └── LoginPage.swift
│   ├── TestCases/
│   │   └── Example/
│   │       └── LoginTests.swift
│   └── Utilities/
│       ├── WaitHelper.swift
│       ├── ScreenshotHelper.swift
│       ├── Logger.swift
│       ├── TestDataManager.swift
│       ├── AssertHelper.swift
│       ├── RetryHelper.swift
│       └── XCUIElement+Extensions.swift
├── Config/
│   └── TestConfig.swift
└── Resources/
    └── TestData/
        └── testData.json
```

## Common Issues

### Issue: "Cannot find 'BaseTestCase' in scope"

**Solution:** Ensure all framework files are added to your test target. Check Build Phases > Compile Sources.

### Issue: "testData.json not found"

**Solution:** 
1. Verify the file is in your test target
2. Check Build Phases > Copy Bundle Resources includes testData.json
3. Ensure the file is in the correct location relative to your test bundle

### Issue: "Element not found" errors

**Solution:**
1. Verify accessibility identifiers are set in your app
2. Use Xcode's Accessibility Inspector to verify identifiers
3. Check that elements are visible and not hidden
4. Increase timeout values if elements load slowly

### Issue: Tests fail immediately on launch

**Solution:**
1. Verify app bundle identifier in TestConfig.swift
2. Check that your app target builds successfully
3. Ensure the app is installed on the simulator/device before running tests

## Next Steps

1. Review the example tests in `Tests/TestCases/Example/`
2. Create your own Page Objects following the pattern in `Tests/Pages/Example/`
3. Write your first test case
4. Customize TestConfig.swift for your needs
5. Add more test data to testData.json

## Additional Resources

- [XCTest Documentation](https://developer.apple.com/documentation/xctest)
- [UI Testing in Xcode](https://developer.apple.com/videos/play/wwdc2015/406/)
- [Accessibility Best Practices](https://developer.apple.com/accessibility/ios/)


