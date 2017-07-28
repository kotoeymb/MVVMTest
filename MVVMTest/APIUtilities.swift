//
//  APIUtilities.swift
//  MVVMTutorial
//
//  Created by Toe Wai Aung on 7/26/17.
//  Copyright © 2017 kotoeymb. All rights reserved.
//

//import UIKit
//import Alamofire
//import RealmSwift
//import SwiftyJSON
//import ObjectMapper
//import AlamofireObjectMapper
//
//
//
//class APIUtilities: NSObject,NSURLConnectionDataDelegate {
////    typealias completionHandler = (_ apiResponseHandler: ApiResponseHandler, _ error: Error?) -> Void
////    typealias responseCompletionHandler = (ApiResponseHandler, Error?)
//    class var sharedInstance : APIUtilities {
//        
//        struct Static {
//            
//            static let instance : APIUtilities = APIUtilities()
//            
//        }
//        return Static.instance
//    }
//    
//    var alamofireManager: SessionManager?
//    let cookies = HTTPCookieStorage.shared
//    
//    //MARK: - API CALL
//    
//    func requestURL(_ URLString: URLConvertible, parameters: [String: Any], headers: HTTPHeaders,completion: @escaping ((URLRequest?, HTTPURLResponse?, Result<Any>) -> Void)) {
//        
//        Alamofire.request(URLString, method: .get, parameters: parameters, encoding: URLEncoding(destination: .httpBody), headers: headers)
//            .responseJSON { response in

//                switch(response.result) {
//                    
//                case .success(_):
//                    if response.result.value != nil{
//                        print("response ->\(response)")
//                        print("value ->\(response.value)")
//                        print("result ->\(response.result)")
//                        print("result value ->\(response.result.value)")
//                        print("Data ->\(response.data)")
//                    
//                    if let responses = Mapper<PostData>().map(JSONObject: response.data) {
//                      print("response value->\(response.result.value)")
//                        let realm = try! Realm()
//                        
//                        try! realm.write {
//                            realm.delete(realm.objects(PostData.self))
//                            realm.add(responses) // clear old one
//                            print("Data -> \(response)")
//                        }
//                        
//                        }
//                        //                }
//                    }
//
//                    break
//                    
//                case .failure(_):
//                    print(response.result.error!)
//                    break
//                }
//        }
//    }
//}

