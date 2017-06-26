//
//  QMSService.swift
//  HTTPService
//  Copyright © 2016 ocbc. All rights reserved.
//

import Foundation

@objc public class ServiceManager:HTTPRequestManager {
    class  func articleSearch(query:String, page: Int, completion: @escaping (_ success:Bool, _ responseData: AnyObject?) -> ()) {
        var urlGet = Url.NYTimes.articleSearch
        if(query.characters.count>0){
            urlGet = urlGet.appending("q=\(query)&page=\(page)")
        }else{
            urlGet = urlGet.appending("page=\(page)")
        }
        
        let req:HTTPRequest = HTTPRequest.init(url: "\(urlGet)", httpMethod: HTTPMethod.GET)

        self.connectService(request:req) { (success, responseData) in
            completion(success,responseData)
        }
    }

    class func connectService(request : HTTPRequest,jsonObject:NSDictionary?=nil, completion: @escaping (_ success:Bool, _ responseData: AnyObject?) -> ()) {
        
        request.httpHeaders = getHttpHeaders()
        
        request.httpBody = jsonObject?.getJsonData()
        
        self.executeHTTPRequest(request: request) { (data, response, error) in
            
            if let err = error {
                print("error: \(err.localizedDescription)")
                completion(false,error as AnyObject?)
            }
            else {
                let responseObject: Any = data!.getJsonResult()

                print("response: \((responseObject as AnyObject).description)")

                do {
                    if let resp = try JSONSerialization.jsonObject(with: data! as Data , options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        print("resp is a dictionary")
                        print(resp)
                    } else if let resp = try JSONSerialization.jsonObject(with: data! as Data , options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                        print("resp is an array")
                        print(resp)
                    } else {
                        print("resp is not valid JSON data")
                    }
                } catch let error as NSError {
                    completion(false, "Invalid - \(error)" as AnyObject)
                    return
                }
                
                completion(true,responseObject as AnyObject)
            }
        }
    }
    
    class func getHttpHeaders() -> NSMutableDictionary {
        let headers:NSMutableDictionary = NSMutableDictionary ()
        headers.setValue("application/json", forKey: "Content-Type")
        headers.setValue(NYConstants.NY_API_KEY, forKey: "api-key")
        return headers;
    }
}
