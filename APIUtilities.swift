//
//  APIUtilities.swift
//  MVVMTutorial
//
//  Created by Toe Wai Aung on 7/26/17.
//  Copyright © 2017 kotoeymb. All rights reserved.
//

import UIKit
import Alamofire


class APIUtilities: NSObject,NSURLConnectionDataDelegate {
    
    class var sharedInstance : APIUtilities {
        
        struct Static {
            
            static let instance : APIUtilities = APIUtilities()
            
        }
        return Static.instance
    }
    
    var alamofireManager: SessionManager?
    let cookies = HTTPCookieStorage.shared
    
    //MARK: - API CALL
    
    func requestURL(_ URLString: URLConvertible, parameters: [String: Any], headers: HTTPHeaders,completion: @escaping ((URLRequest?, HTTPURLResponse?, Result<Any>) -> Void)) {
        
        Alamofire.request(URLString, method: .post, parameters: parameters, encoding: URLEncoding(destination: .httpBody), headers: headers)
            .responseJSON { response in
                
                switch(response.result) {
                    
                case .success(_):
                    if response.result.value != nil{
                        //print(response.result.value)
                        completion(response.request,response.response,response.result as Result<Any>)
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error!)
                    break
                }
        }
    }
}
