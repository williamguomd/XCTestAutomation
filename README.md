# XCTest Automation Framework

A comprehensive iOS UI automation testing framework built on XCTest, following industry best practices.

## Features

- **Page Object Model (POM)** pattern for maintainable test code
- **Base test classes** with common setup and teardown
- **Utility classes** for common operations (waiting, screenshots, logging)
- **Configuration management** for different environments
- **Test data management** with JSON support
- **Screenshot and reporting** utilities
- **Reusable components** and helpers

## Project Structure

```
XCTestAutomation/
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
│       └── TestDataManager.swift
├── Config/
│   └── TestConfig.swift
└── Resources/
    └── TestData/
        └── testData.json
```

## Setup

1. Create a new iOS project or add this framework to an existing project
2. Add all Swift files to your test target
3. Update `TestConfig.swift` with your app bundle identifier
4. Configure test data in `Resources/TestData/testData.json`

## Usage

### Writing Tests

```swift
import XCTest
@testable import YourApp

class LoginTests: BaseTestCase {
    
    func testSuccessfulLogin() {
        let loginPage = LoginPage(app: app)
        loginPage.navigateToLogin()
        loginPage.enterUsername("testuser")
        loginPage.enterPassword("password123")
        loginPage.tapLoginButton()
        
        // Assertions
        XCTAssertTrue(loginPage.isLoggedIn())
    }
}
```

### Creating Page Objects

```swift
import XCTest

class LoginPage: BasePage {
    
    // UI Elements
    private var usernameField: XCUIElement {
        app.textFields["username"]
    }
    
    private var passwordField: XCUIElement {
        app.secureTextFields["password"]
    }
    
    private var loginButton: XCUIElement {
        app.buttons["loginButton"]
    }
    
    // Actions
    func enterUsername(_ username: String) {
        waitForElement(usernameField)
        usernameField.tap()
        usernameField.typeText(username)
    }
    
    func enterPassword(_ password: String) {
        waitForElement(passwordField)
        passwordField.tap()
        passwordField.typeText(password)
    }
    
    func tapLoginButton() {
        waitForElement(loginButton)
        loginButton.tap()
    }
    
    // Verifications
    func isLoggedIn() -> Bool {
        return app.navigationBars["Home"].exists
    }
}
```

## Best Practices

1. **Use Page Object Model**: Separate UI interactions from test logic
2. **Use Base Classes**: Inherit from `BaseTestCase` for common setup
3. **Wait for Elements**: Always use `waitForElement` before interacting
4. **Use Test Data**: Load test data from JSON files instead of hardcoding
5. **Take Screenshots**: Use screenshot utilities for debugging failures
6. **Keep Tests Independent**: Each test should be able to run standalone
7. **Use Descriptive Names**: Test and method names should clearly describe intent
8. **Use Accessibility Identifiers**: Always use accessibility identifiers instead of labels
9. **Handle Async Operations**: Use wait helpers for elements that load asynchronously
10. **Organize Tests**: Group related tests in test classes, use descriptive test names

## Framework Components

### Base Classes
- **BaseTestCase**: Base class for all test cases with common setup/teardown
- **BasePage**: Base class for Page Object Model pattern

### Utilities
- **WaitHelper**: Wait for elements with various conditions
- **ScreenshotHelper**: Capture screenshots during test execution
- **Logger**: Structured logging for test execution
- **TestDataManager**: Load and manage test data from JSON
- **AssertHelper**: Custom assertions for common checks
- **RetryHelper**: Retry flaky operations

### Configuration
- **TestConfig**: Centralized configuration management

## Accessibility Identifiers

For the framework to work, your app must use accessibility identifiers:

```swift
// In your app code
button.accessibilityIdentifier = "loginButton"
textField.accessibilityIdentifier = "usernameTextField"
```

See `SETUP.md` for detailed integration instructions.

## Running Tests

- Run all tests: `Cmd + U` in Xcode
- Run specific test: Click the diamond icon next to the test method
- Run from command line: `xcodebuild test -scheme YourScheme -destination 'platform=iOS Simulator,name=iPhone 14'`

## Configuration

Update `TestConfig.swift` to configure:
- App bundle identifier
- Launch arguments
- Timeouts
- Environment settings

## License

MIT License

