//
//  ApiTest.swift
//  MarketCapTests
//
//  Created by Denis on 16.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import XCTest
@testable import MarketCap

struct MyIpResponse: Decodable {
    var ip: String
    var country: String
    var cc: String
}

class NetworkTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetch () {

        let myIp = XCTestExpectation (description: "Fetched My IP")

        Network.fetch (url: "https://api.myip.com", then: {

            (data: Data?, response: URLResponse?, error: Error?) in
                    
            print ("error \(String(describing: error))")
            print ("data \(String(describing: data))")
            print ("response \(String(describing: response))")
            
            XCTAssertNotNil (data)
            XCTAssertNotNil (response)
            XCTAssertNil (error)
            
            myIp.fulfill ()
        })

        wait (for: [myIp], timeout: 10.0)
    }
    
    func testFetchJson () {
        
        let myIp = XCTestExpectation (description: "Fetched My IP")

        Network.fetchJson (url: "https://api.myip.com", then: {

            (data: MyIpResponse?, response: URLResponse?, error: Error?) -> Void in

            print ("Requested data: \(String(describing: data))")
            
            XCTAssertNotNil (data)
            XCTAssertNotNil (data?.ip)
            XCTAssertNotNil (data?.country)
            XCTAssertNotNil (data?.cc)

            myIp.fulfill ()
        })

        wait (for: [myIp], timeout: 10.0)
    }
    
    func testGetJson () {
        
        let myIp = XCTestExpectation (description: "Fetched My IP")

        Network.getJson (url: "https://api.myip.com", then: {

            (data: MyIpResponse?, response: URLResponse?, error: Error?) -> Void in

            print ("Requested data: \(String(describing: data))")
            
            XCTAssertNotNil (data)
            XCTAssertNotNil (data?.ip)
            XCTAssertNotNil (data?.country)
            XCTAssertNotNil (data?.cc)

            myIp.fulfill ()
        })

        wait (for: [myIp], timeout: 10.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
