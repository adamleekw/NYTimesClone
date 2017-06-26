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
    var detailvc: DetailViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        detailvc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
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
    
    func testModel(){
        let jsonStr = "{ \"web_url\": \"https://www.nytimes.com/aponline/2017/06/26/world/europe/ap-eu-germany-nationalist-party.html\", \"snippet\": \"The nationalist Alternative for Germany party has given a prominent member an official warning after the leak of a WhatsApp chat in which he was shown using the slogan ...\", \"lead_paragraph\": \"The nationalist Alternative for Germany party has given a prominent member an official warning after the leak of a WhatsApp chat in which he was shown using the slogan ...\", \"abstract\": null, \"print_page\": null, \"blog\": [], \"source\": \"AP\", \"multimedia\": [], \"headline\": { \"main\": \"German Nationalist Party Warns Prominent Member on Chat Leak\", \"print_headline\": \"German Nationalist Party Warns Prominent Member on Chat Leak\" }, \"keywords\": [], \"pub_date\": \"2017-06-26T08:06:59+0000\", \"document_type\": \"article\", \"news_desk\": \"None\", \"section_name\": \"World\", \"subsection_name\": \"Europe\", \"byline\": { \"person\": [], \"original\": \"By THE ASSOCIATED PRESS\", \"organization\": \"THE ASSOCIATED PRESS\" }, \"type_of_material\": \"News\", \"_id\": \"5950c0ac7c459f257c1abfce\", \"word_count\": 131, \"slideshow_credits\": null }"
            
            // WHEN
        if let data = jsonStr.data(using: .utf8) {
            do {
                let dic =  try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let sut = ArticleSearchModel(JSON:dic)
                XCTAssertEqual(sut.title, "German Nationalist Party Warns Prominent Member on Chat Leak")
                XCTAssertEqual(sut.snippet, "The nationalist Alternative for Germany party has given a prominent member an official warning after the leak of a WhatsApp chat in which he was shown using the slogan ...")
                XCTAssertEqual(sut.webUrl, "https://www.nytimes.com/aponline/2017/06/26/world/europe/ap-eu-germany-nationalist-party.html")
                XCTAssertEqual(sut.date, "2017-06-26T08:06:59+0000")
                XCTAssertEqual(sut.img, [])
            } catch {
                XCTFail("Invalid JSON")
            }
        }
    }
    
    func testDictJson(){
        let dic = NSMutableDictionary()
        dic.setValue("one", forKey: "Version")
        XCTAssertNotNil(dic.getJsonData())
    }
    
    func testValidDate(){
        XCTAssertNotNil(Util.dateFromStringWithFormat(dateString: "2017-06-26T13:34:23+0000", formatString: "yyyy-mm-dd'T'HH:mm:ss+0000"))
        XCTAssertNotNil(Util.dateFromStringWithFormat(dateString: "1988-07-14T00:00:00Z", formatString: "yyyy-mm-dd'T'HH:mm:ss'Z'"))
        
    }
    
    
    func testSUT_ConformsToSearchBarDelegateProtocol() {
        XCTAssertTrue(self.vc.responds(to: #selector(vc.searchBarTextDidBeginEditing(_:))))
        XCTAssertTrue(self.vc.responds(to: #selector(vc.searchBarTextDidEndEditing(_:))))
        XCTAssertTrue(self.vc.responds(to: #selector(vc.searchBarSearchButtonClicked(_:))))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
