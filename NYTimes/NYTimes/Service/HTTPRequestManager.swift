//
//  HTTPRequestManager.swift
//  ESSMobileConnectServices
//
//  Created by MDT007MBP on 21/2/17.
//  Copyright © 2017 ocbc. All rights reserved.
//

import UIKit

@objc public class HTTPRequestManager: NSObject {

     class  func executeHTTPRequest(request : HTTPRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {

        guard let urlString = URL(string: request.serviceURL!) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: urlString)
        urlRequest.httpMethod = request.httpMethod?.rawValue
        urlRequest.timeoutInterval = TimeInterval(request.timeoutInterval)
        urlRequest.allHTTPHeaderFields = request.httpHeaders  as! [String : String]?
        if (request.httpMethod == HTTPMethod(rawValue: "POST") || request.httpMethod == HTTPMethod(rawValue: "DELETE")) {
            urlRequest.httpBody = request.httpBody as Data?
        }

        // set up the session
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                return
            }
            completion(data,response,error)
       }
        task.resume()
    }
}
