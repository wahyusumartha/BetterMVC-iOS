//
//  ConnectionTests.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 06/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import XCTest
@testable import gallery
import OHHTTPStubs

class ConnectionTests: XCTestCase {
    let baseURL = NSURL(string: "http://static.westwing.de/")
    let resource = Resource(path: "cms/dont-delete/programming_task/data.json",
                            method: .GET)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testURLResources() {
        XCTAssertEqual(self.resource.method.rawValue,
                       Method.GET.rawValue)
        XCTAssertEqual(self.resource.path, "cms/dont-delete/programming_task/data.json")
        XCTAssertEqual(self.resource.toRequest(from: self.baseURL!), NSURLRequest(URL: self.baseURL!))
    }
    
    func testFetchData_Success_StatusCode_200() {
        let stubData = MockFileHelper.shared.readFromFile("products")
        OHHTTPStubs.stubRequestsPassingTest({_ in
            return true
            }, withStubResponse: { _ in
                return OHHTTPStubsResponse(data: stubData!,
                    statusCode: 200,
                    headers: nil)
        })
        let expectation = self.expectationWithDescription(self.name!)

        let connectable = Connection(url: self.baseURL!)
        connectable.makeConnection(self.resource) { (result) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, stubData!)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error When make connection \(error)")
                expectation.fulfill()
            }
        }
        self.waitForExpectationsWithTimeout(1,
                                            handler: nil)
    }
}
