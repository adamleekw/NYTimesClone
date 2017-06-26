//
//  ArticleSearchModel.swift
//  NYTimes
//
//  Created by Adam on 25/6/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//

import Foundation
@objc public class ArticleSearchModel:NSObject {
    
    var title = ""
    var snippet = ""
    var date = ""
    var img = NSMutableArray()
    var webUrl = ""
    
    override init() {}

    init(JSON: [String:Any]) {
        let dic = JSON["headline"] as! [String : Any]
        self.title = stringForJSONKey(JSON: dic ,key:"main")
        self.snippet = stringForJSONKey(JSON: JSON,key:"snippet")
        self.date = stringForJSONKey(JSON: JSON,key:"pub_date")
        self.webUrl = stringForJSONKey(JSON: JSON,key:"web_url")
        self.img = arrForJSONKey(JSON: JSON,key:"multimedia")
    }
}

public func stringForJSONKey(JSON: [String:Any], key: String) -> String{
    if(JSON[key] as? String != nil){
        return (JSON[key] as! String)
    }
    else {
        return ""
    }
}

public func falseForJSONKey(JSON: [String:Any], key: String) -> Bool{
    if(JSON[key] as? Bool != nil){
        return (JSON[key] as! Bool)
    }
    else {
        return false
    }
}

public func arrForJSONKey(JSON: [String:Any], key: String) -> NSMutableArray{
    if(JSON[key] as? NSMutableArray != nil){
        return (JSON[key] as! NSMutableArray)
    }
    else {
        return NSMutableArray()
    }
}
