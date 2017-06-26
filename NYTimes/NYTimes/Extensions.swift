//
//  Extensions.swift
//  NYTimes
//
//  Created by Adam on 25/6/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//
import Foundation

extension String {
    var serviceURL: String? {
        return self.serviceURL
    }
    
    var jsonObject:NSDictionary? {
        let JSONData = self.data(using: String.Encoding.utf8)
        do {
            let JSON = try JSONSerialization.jsonObject(with: JSONData!, options:JSONSerialization.ReadingOptions(rawValue: 0))
            guard let JSONDictionary :NSDictionary = JSON as? NSDictionary else {
                // put in function
                return nil
            }
            return JSONDictionary
        }
        catch let JSONError as NSError {
            print("\(JSONError)")
        }
        return nil
    }
}

extension Data {
    
    var jsonObject:NSDictionary? {
        do {
            let JSON = try JSONSerialization.jsonObject(with: self as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
            guard let JSONDictionary :NSDictionary = JSON as? NSDictionary else {
                // put in function
                return nil
            }
            return JSONDictionary
        }
        catch let JSONError as NSError {
            print("\(JSONError)")
        }
        return nil
    }
    
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



