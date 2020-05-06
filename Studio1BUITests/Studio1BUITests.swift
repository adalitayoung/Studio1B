//
//  Studio1BUITests.swift
//  Studio1BUITests
//
//  Created by Gabrielle Walker on 6/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import XCTest

class Studio1BUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStaffLogin() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.staticTexts["Log In As A Staff Member"]/*[[".buttons[\"Log In As A Staff Member\"].staticTexts[\"Log In As A Staff Member\"]",".staticTexts[\"Log In As A Staff Member\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["johnsmith@gmail.com"].tap()
        app.textFields["johnsmith@gmail.com"].typeText("test@test.com")
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("password")
        
        let staffManagement = app.buttons["Staff Management"]
        XCTAssertFalse(staffManagement.exists)
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: staffManagement, handler: nil)
        app.buttons["LOG IN"].tap()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(staffManagement.exists)

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
