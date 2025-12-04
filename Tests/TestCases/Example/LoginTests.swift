//
//  LoginTests.swift
//  XCTestAutomation
//
//  Example test cases for Login functionality
//

import XCTest

class LoginTests: BaseTestCase {
    
    var loginPage: LoginPage!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        loginPage = LoginPage(app: app)
    }
    
    // MARK: - Positive Test Cases
    
    func testSuccessfulLogin() {
        // Arrange
        let username = TestDataManager.shared.getString(for: "users.valid.username") ?? "testuser"
        let password = TestDataManager.shared.getString(for: "users.valid.password") ?? "password123"
        
        // Act
        loginPage.navigateToLogin()
        loginPage.login(username: username, password: password)
        
        // Assert
        XCTAssertTrue(loginPage.isLoggedIn(), "User should be logged in successfully")
        logger.log("Successfully logged in with username: \(username)")
    }
    
    func testLoginScreenElementsDisplayed() {
        // Act
        loginPage.navigateToLogin()
        
        // Assert
        XCTAssertTrue(loginPage.isLoginScreenDisplayed(), "Login screen should be displayed")
        XCTAssertTrue(loginPage.isLoginButtonEnabled(), "Login button should be enabled")
    }
    
    // MARK: - Negative Test Cases
    
    func testLoginWithInvalidCredentials() {
        // Arrange
        let username = TestDataManager.shared.getString(for: "users.invalid.username") ?? "invaliduser"
        let password = TestDataManager.shared.getString(for: "users.invalid.password") ?? "wrongpassword"
        
        // Act
        loginPage.navigateToLogin()
        loginPage.login(username: username, password: password)
        
        // Assert
        XCTAssertTrue(loginPage.isErrorMessageDisplayed(), "Error message should be displayed")
        let errorMessage = loginPage.getErrorMessage()
        XCTAssertFalse(errorMessage.isEmpty, "Error message should not be empty")
        logger.warning("Login failed as expected with invalid credentials")
    }
    
    func testLoginWithEmptyUsername() {
        // Act
        loginPage.navigateToLogin()
        loginPage.enterPassword("password123")
        loginPage.tapLoginButton()
        
        // Assert
        // Depending on your app, you might check for validation message
        // or that login button is disabled
        XCTAssertTrue(loginPage.isLoginScreenDisplayed(), "Should remain on login screen")
    }
    
    func testLoginWithEmptyPassword() {
        // Act
        loginPage.navigateToLogin()
        loginPage.enterUsername("testuser")
        loginPage.tapLoginButton()
        
        // Assert
        XCTAssertTrue(loginPage.isLoginScreenDisplayed(), "Should remain on login screen")
    }
    
    // MARK: - Edge Cases
    
    func testLoginWithSpecialCharacters() {
        // Arrange
        let username = "user@example.com"
        let password = "P@ssw0rd!#$"
        
        // Act
        loginPage.navigateToLogin()
        loginPage.login(username: username, password: password)
        
        // Assert
        // Behavior depends on your app's validation
        // This test ensures special characters don't break the app
        XCTAssertTrue(loginPage.isLoginScreenDisplayed() || loginPage.isLoggedIn(),
                     "App should handle special characters gracefully")
    }
    
    func testForgotPasswordNavigation() {
        // Act
        loginPage.navigateToLogin()
        loginPage.tapForgotPasswordButton()
        
        // Assert
        // Verify navigation to forgot password screen
        // Adjust based on your app's implementation
        waitForAppToBeIdle()
        XCTAssertTrue(app.buttons["Reset Password"].exists || 
                     app.staticTexts["Forgot Password"].exists,
                     "Should navigate to forgot password screen")
    }
    
    // MARK: - Performance Tests
    
    func testLoginPerformance() {
        measure {
            loginPage.navigateToLogin()
            loginPage.login(username: "testuser", password: "password123")
        }
    }
}


