//
//  civil_warTests.swift
//  civil-warTests
//
//  Created by Joseph Mohr on 1/30/16.
//  Copyright © 2016 Mohr. All rights reserved.
//

import XCTest
@testable import civil_war

class civil_warTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testVectorMath(){
        let pointA = CGPoint(x: 1.0, y: 1.0)
        let pointB = CGPoint(x: 2.0, y: 2.0)
        XCTAssert(pointA - pointB == CGPoint(x:-1.0, y: -1.0))
        XCTAssert(pointA + pointB == CGPoint(x:3.0, y: 3.0))
        XCTAssert(pointB * 3 == CGPoint(x:6.0, y: 6.0))
        XCTAssert(pointB / 2 == CGPoint(x:1.0, y: 1.0))
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
