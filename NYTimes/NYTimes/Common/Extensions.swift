//
//  Extensions.swift
//  NYTimes
//
//  Created by Adam on 25/6/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//
import Foundation

extension Data {
    func  getJsonResult()->Any {
        var jsonResult:Any? = nil
        do {
            jsonResult = try JSONSerialization.jsonObject(with: self as Data , options: JSONSerialization.ReadingOptions.mutableContainers)
        }
        catch {
            let html = String(data: self as Data, encoding: String.Encoding.utf8)
            print("\(html ?? "Invalid")")
            jsonResult = html
            print("Invalid Data.")
        }
        return jsonResult!
    }
}

extension NSDictionary  {
    
    func  getJsonData()->NSData {
        var jsonData:NSData? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) as NSData?
        }
        catch {
            print("Invalid Data.")
        }
        return jsonData!
    }
}



