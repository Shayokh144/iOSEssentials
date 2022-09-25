//
//  LoginUITest.swift
//  AppUITests
//
//  Created by nimble on 25/9/22.
//

import XCTest

class LoginUITest: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
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
        let loginButton = app.buttons["LOGIN"]

        XCTAssert(loginButton.exists)
    }

    func test_ui_elements_with_accessibilityIdentifier() throws {
        let loginButton = app.buttons["loginButtonIdentifier"]

        XCTAssert(loginButton.exists)
        XCTAssertEqual(loginButton.label, "LOGIN")
    }
}
