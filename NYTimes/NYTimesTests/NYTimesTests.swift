//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Adam on 26/6/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {
    var vc: ViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }
    
    func testArticleCall() {
        
        // 1. Define an expectation
        let expect = expectation(description: "Service call for article search")
        
        // 2. Exercise the asynchronous code
        ServiceManager.articleSearch (query: "", page: 0,completion: { (success, responseData) in
            expect.fulfill()
        })
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 30) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testValidDate(){
        XCTAssertNotNil(Util.dateFromStringWithFormat(dateString: "2017-06-26T13:34:23+0000", formatString: "yyyy-mm-dd'T'HH:mm:ss+0000"))
        XCTAssertNotNil(Util.dateFromStringWithFormat(dateString: "1988-07-14T00:00:00Z", formatString: "yyyy-mm-dd'T'HH:mm:ss'Z'"))
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
