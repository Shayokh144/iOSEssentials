//
//  WatherTodayUITests.swift
//  WatherTodayUITests
//
//  Created by nimble on 18/8/22.
//

import XCTest

class WatherTodayUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app) // init snapshot
        app.launch()
        sleep(10)
        snapshot("01UserEntry")
        let cityTextField = app.textFields["cityNameTextFieldId"]
        cityTextField.tap()
        sleep(3)
        cityTextField.typeText("Dhaka\n")
        sleep(10)
        snapshot("02UserCityResult")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
