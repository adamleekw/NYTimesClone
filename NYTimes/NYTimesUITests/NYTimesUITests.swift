//
//  NYTimesUITests.swift
//  NYTimesUITests
//
//  Created by Adam on 26/6/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//

import XCTest

class NYTimesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClickNewsAndBack() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let firstChild = collectionViewsQuery.children(matching:.any).element(boundBy: 0)
        firstChild.tap()
        let backButton = app.navigationBars["The New York Times"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        backButton.tap()
    }
    
    func testClickNewsAndSwipeLeft() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let firstChild = collectionViewsQuery.children(matching:.any).element(boundBy: 0)
        firstChild.tap()
        
        let firstWeb = app.webViews.children(matching: .any).element(boundBy:0)
        firstWeb.swipeLeft()
    }
    
    func testClickNewsAndSwipeRight() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let firstChild = collectionViewsQuery.children(matching:.any).element(boundBy: 0)
        firstChild.tap()
        
        let firstWeb = app.webViews.children(matching: .any).element(boundBy:0)
        firstWeb.swipeRight()
    }

}
