//
//  CryptoTrackerTests.swift
//  CryptoTrackerTests
//
//  Created by iMac on 29/01/2022.
//

import XCTest

@testable import CryptoTracker

class CryptoTrackerTests: XCTestCase {

    var sut: ViewController! //System Under Test (SUT)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = ViewController()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func test() {
      // given
        sut.timerInterval = 2   //for quick testing set to 2
        sut.setUpAndStartTimer()
        print("Pause here to see the API responses")
    }

    
}
