//
//  HTTPRequest.swift
//  ESSMobileConnectServices
//
//  Created by MDT007MBP on 22/2/17.
//  Copyright © 2017 ocbc. All rights reserved.
//

import UIKit

enum HTTPMethod:String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class HTTPRequest: NSObject {

    var serviceURL:String?
    var httpHeaders:NSMutableDictionary?
    var httpBody:NSData?
    var timeoutInterval:CGFloat
    var httpMethod:HTTPMethod?
    
    init(url: String, httpMethod: HTTPMethod,body:NSData?=nil) {
        self.serviceURL = url
        self.httpHeaders = NSMutableDictionary()
        self.httpBody = body
        self.timeoutInterval = 30.0
        self.httpMethod = HTTPMethod(rawValue: httpMethod.rawValue)
    }
    
}
