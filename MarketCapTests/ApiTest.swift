//
//  ApiTest.swift
//  MarketCapTests
//
//  Created by Denis on 19.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import XCTest
@testable import MarketCap

class ApiTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testList () {

        let listPromise = XCTestExpectation (description: "Fetched CMC Currency List")

        Api.list () {

            (data: [Currency]?, response: URLResponse?, error: Error?) in
                    
            print ("error \(String(describing: error))")
            
            for currency in data ?? [] {
                print ("Currency: \(String (describing: currency))")
            }
            
            XCTAssertNotNil (data)
            XCTAssertNil (error)
            
            listPromise.fulfill ()
        }

        wait (for: [listPromise], timeout: 10.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
