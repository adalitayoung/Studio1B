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
    
    var sut: StaffLogin!
    
    override func setUp()  {
  //      self.sut = CreateNewStaffRecord()
        super.setUp()
//        sut = UIStoryboard(name: "Main", bundle: nil)
//          .instantiateInitialViewController() as? StaffLogin
////let testBundle = Bundle(for: type(of: self))
    }

//    func test_CreateNewStaffRecord(){
//        self.sut.createRecord(AccountName: "test", AccountNumber: 123456, BSBNumber: 123, ContactNumber: "1234567891", DateOfBirth: "08/02/2000", Email: "test@test.com", FirstName: "unit" as! String, LastName: "test" as! String, Role: "RestaurantManager", Password: "unittest")
//
//        var x = [Any?]()
//        self.sut.db.collection("Staff").getDocuments() {
//            (querySnapshot, err) in
//              if let err = err {
//                  print ("Error")
//              }
//              else {
//                print("!!")
//                for document in querySnapshot!.documents{
//                    x.append(document.data())
//                    print(x)
//                }
//              }
//                         XCTAssertEqual(x.count, 1) //enter assert statement
//        }
//
//
//    }
    
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testGameStyleSwitch() {
//
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
