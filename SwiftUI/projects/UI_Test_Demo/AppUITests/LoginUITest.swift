//
//  LoginUITest.swift
//  AppUITests
//
//  Created by Taher on 25/9/22.
//

import XCTest

class LoginUITest: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchEnvironment = ["ENV_TEST_SHOULD_SHOW_ANIMATION" : "YES"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func test_static_text() throws {
        let welcomeText = app.staticTexts["Welcome"]

        XCTAssert(welcomeText.exists)
    }

    func test_static_button() throws {
        // using text
        let loginButton = app.buttons["LOGIN"]
        
        XCTAssert(loginButton.exists)

        // using predicate
        let predicate = NSPredicate(format: "label contains 'LOGIN'")
        let loginButtonFromPredicate = app.buttons.element(matching: predicate)

        XCTAssert(loginButtonFromPredicate.exists)
    }

    func test_ui_elements_with_accessibilityIdentifier() throws {
        let loginButton = app.buttons["loginButtonIdentifier"]

        XCTAssert(loginButton.exists)
        XCTAssertEqual(loginButton.label, "LOGIN")
    }

    func test_login_button_removal_from_view_after_tap() throws {
        app.terminate()
        app.launchEnvironment = ["ENV_TEST_SHOULD_SHOW_ANIMATION" : "NO"]
        app.launch()

        let loginButton = app.buttons["loginButtonIdentifier"]
        loginButton.tap()
        XCTAssertFalse(loginButton.exists)
    }

    func test_login_failed_message_shown_for_wrong_data() throws {
        let loginButton = app.buttons["loginButtonIdentifier"]
        loginButton.tap()

        let failedMsg = app.staticTexts["loginFailedTextId"]
        XCTAssert(failedMsg.waitForExistence(timeout: 7.0))
    }

    func test_login_flow_with_correct_data() throws {
        let loginButton = app.buttons["loginButtonIdentifier"]
        let userNameTextField = app.textFields["usernameTextFieldId"]
        let passwordTextField = app.secureTextFields["passwordSecureFieldId"]

        // check existance of all elements
        XCTAssert(loginButton.exists)
        XCTAssert(userNameTextField.exists)
        XCTAssert(passwordTextField.exists)

        // write username
        userNameTextField.tap()
        userNameTextField.typeText("abc")
        sleep(1) // optional delay

        // write password
        passwordTextField.tap()
        passwordTextField.typeText("xyz")
        sleep(1) // optional delay

        // tap login button
        loginButton.tap()

        // check welcome text
        XCTAssert(app.staticTexts["Nice to see you here...\n\nIn the dark side of the moon!"].waitForExistence(timeout: 7.0))
    }

    func test_swipe_gesture() {
        let loginButton = app.buttons["loginButtonIdentifier"]
        let userNameTextField = app.textFields["usernameTextFieldId"]
        let passwordTextField = app.secureTextFields["passwordSecureFieldId"]
        userNameTextField.tap()
        userNameTextField.typeText("abc")
        passwordTextField.tap()
        passwordTextField.typeText("xyz")
        loginButton.tap()
        app.swipeLeft()
        XCTAssert(app.staticTexts["LEFT SWIPE"].exists)
        app.swipeRight()
        XCTAssert(app.staticTexts["RIGHT SWIPE"].exists)
    }

    func test_taking_screenshot_of_specific_element() {
        // will take screenshot of login button only
        let loginButton = app.buttons["loginButtonIdentifier"]
        let loginButtonScreenShot = loginButton.screenshot()
        add(getAttachment(from: loginButtonScreenShot, name: "Login Button Screenshot"))
    }

    func test_taking_screenshot_of_full_screen() {
        app.terminate()
        app.launchEnvironment = ["ENV_TEST_SHOULD_SHOW_ANIMATION" : "NO"]
        app.launch()
        let loginButton = app.buttons["loginButtonIdentifier"]
        let userNameTextField = app.textFields["usernameTextFieldId"]
        let passwordTextField = app.secureTextFields["passwordSecureFieldId"]
        userNameTextField.tap()
        userNameTextField.typeText("abc")
        passwordTextField.tap()
        passwordTextField.typeText("xyz")

        // will take screenshot of full window of login page after tap on login button
        var fullWindowScreenshot = app.screenshot()
        add(getAttachment(from: fullWindowScreenshot, name: "Full window screenshot before login button clicked"))

        loginButton.tap()
        
        fullWindowScreenshot = app.screenshot()
        add(getAttachment(from: fullWindowScreenshot, name: "Full window screenshot after login button clicked"))
    }

    func getAttachment(from screenShot: XCUIScreenshot, name: String) -> XCTAttachment {
        let attachment = XCTAttachment(screenshot: screenShot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        return attachment
    }
}
