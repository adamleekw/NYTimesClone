//
//  Util.swift
//  NYTimes
//
//  Created by Adam on 25/6/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//

import Foundation

@objc public class Util: NSObject{

    class func dateFromStringWithFormat(dateString:String, formatString:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        if(dateString.characters.last == "Z"){
            dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss'Z'"
        }
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        return dateFormatter.date(from: dateString)!
    }

    class func stringFromDateWithFormat(date:Date, formatString:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        return dateFormatter.string(from: date)
    }
    
}
