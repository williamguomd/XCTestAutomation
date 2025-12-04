//
//  LoginPage.swift
//  XCTestAutomation
//
//  Example Page Object for Login screen
//

import XCTest

class LoginPage: BasePage {
    
    // MARK: - UI Elements
    
    private var usernameField: XCUIElement {
        app.textFields["usernameTextField"]
    }
    
    private var passwordField: XCUIElement {
        app.secureTextFields["passwordTextField"]
    }
    
    private var loginButton: XCUIElement {
        app.buttons["loginButton"]
    }
    
    private var forgotPasswordButton: XCUIElement {
        app.buttons["forgotPasswordButton"]
    }
    
    private var errorMessageLabel: XCUIElement {
        app.staticTexts["errorMessageLabel"]
    }
    
    private var welcomeLabel: XCUIElement {
        app.staticTexts["welcomeLabel"]
    }
    
    // MARK: - Actions
    
    /// Navigate to login screen
    func navigateToLogin() {
        // Implementation depends on your app's navigation
        // This is just an example
        if app.buttons["Login"].exists {
            tapElement(app.buttons["Login"])
        }
    }
    
    /// Enter username
    func enterUsername(_ username: String) {
        typeText(username, into: usernameField)
    }
    
    /// Enter password
    func enterPassword(_ password: String) {
        typeText(password, into: passwordField)
    }
    
    /// Tap login button
    func tapLoginButton() {
        tapElement(loginButton)
    }
    
    /// Tap forgot password button
    func tapForgotPasswordButton() {
        tapElement(forgotPasswordButton)
    }
    
    /// Perform login with credentials
    func login(username: String, password: String) {
        enterUsername(username)
        enterPassword(password)
        tapLoginButton()
    }
    
    /// Clear username field
    func clearUsername() {
        clearText(in: usernameField)
    }
    
    /// Clear password field
    func clearPassword() {
        clearText(in: passwordField)
    }
    
    // MARK: - Verifications
    
    /// Check if login screen is displayed
    func isLoginScreenDisplayed() -> Bool {
        return elementExists(loginButton)
    }
    
    /// Check if user is logged in (navigated away from login screen)
    func isLoggedIn() -> Bool {
        // Adjust based on your app's post-login screen
        return !isLoginScreenDisplayed() && app.navigationBars.count > 0
    }
    
    /// Get error message text
    func getErrorMessage() -> String {
        if elementExists(errorMessageLabel) {
            return getText(from: errorMessageLabel)
        }
        return ""
    }
    
    /// Check if error message is displayed
    func isErrorMessageDisplayed() -> Bool {
        return elementExists(errorMessageLabel)
    }
    
    /// Check if login button is enabled
    func isLoginButtonEnabled() -> Bool {
        return elementExists(loginButton) && loginButton.isEnabled
    }
    
    /// Get welcome message text
    func getWelcomeMessage() -> String {
        if elementExists(welcomeLabel) {
            return getText(from: welcomeLabel)
        }
        return ""
    }
}


