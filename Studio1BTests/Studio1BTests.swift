//
//  Studio1BTests.swift
//  Studio1BTests
//
//  Created by David Bolis on 4/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import XCTest

@testable import Studio1B
class Studio1BTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
    }

    func testLoggingin(){


    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGameStyleSwitch() {
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
