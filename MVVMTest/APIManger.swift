//
//  APIManger.swift
//  MVVMTutorial
//
//  Created by Toe Wai Aung on 7/25/17.
//  Copyright © 2017 kotoeymb. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import SwiftyUserDefaults
import AlamofireObjectMapper
import RealmSwift
import HTTPStatusCodes

typealias completionHandler = (_ apiResponseHandler: ApiResponseHandler, _ error: Error?) -> Void
typealias responseCompletionHandler = (_ apiResponseHandler: ApiResponseHandler, _ error: Error?) -> Void

enum ApiErrorCode: UInt {
    case Success = 0
    case ServerError = 999
    case UnAuthorized = 100 // Not authorized request
    case DuplicateSession = 101 // Other device is using this account
    case UnRegistered = 103 // Not register yet
    case UnActivated = 104 // Not activated yet
    case InvalidLogin = 105 // Email and Password mismatch.
    case ParameterMissing = 108 // Parameter doesn't fullfill.
    
    func isEqalTo(code:String) -> Bool {
        let codeInt = UInt(code)
        return self.rawValue == codeInt
    }
    
    func isEqalTo(code:UInt) -> Bool {
        return self.rawValue == code
    }
}

class APIManager {
    
    enum Router: URLConvertible {
        
        case GetPostData()
        
        
        var path: String {
            switch self {
            case .GetPostData:
                return "/posts"
            }
        }
        
        func asURL() throws -> URL {
            let url = try postRequestUrl.asURL()
            return url.appendingPathComponent(path)
        }
        
    }
    
    // Singleton
    static let sharedInstance = APIManager()
    
    var defaultManager: Alamofire.SessionManager!
    
    // Exception url will not be checked for Error
    var exceptions:[Router] = [.GetPostData()]
    
    init() {
        
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            :
        ]
        
        let sessionManager = SessionManager(
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        self.defaultManager = sessionManager
        
    }
    
    func sendJSONRequest(method: HTTPMethod, path: URLConvertible, parameters: [String : Any]?, completed: @escaping responseCompletionHandler) {
        let headers = [
            "Authorization": getAuthorizationCode(path: path),
            "Content-Type" : "application/json"
        ]
        
        let updatedParams = parameters
        
        sendJSONRequest(method: method, path: path, parameters: updatedParams, encoding: JSONEncoding.default, headers: headers, completed: completed)
    }
   
    private func getAuthorizationCode(path : URLConvertible) -> String {
        
        let auth = ""
        
        return auth
    }
    
    // Common JSON Request
    private func sendJSONRequest(method: HTTPMethod, path: URLConvertible, parameters: [String : Any]?, encoding: ParameterEncoding, headers: [String : String],completed: @escaping responseCompletionHandler) {
        
        defaultManager.request(path, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseJSON { (response) in
                
                switch response.result {
                    
                case .success(let data):
//                        print("printdata-\(data)")
                        let apiResponseHandler : ApiResponseHandler = ApiResponseHandler(json: data)
                        completed(apiResponseHandler, nil)
                    
                    break
                    
                case .failure(let error):
                    
                    let apiResponseHandler:ApiResponseHandler = ApiResponseHandler(json: nil)
                    
                    completed(apiResponseHandler, error)
                    
                    break
                }
        }
    }
    
   
    private func validateResponseError (data: Dictionary<String, AnyObject>?) -> Bool {
        
        return validateResponseError(data: data, showError: true)
    }
    
    private func validateResponseError (data: Dictionary<String, AnyObject>?, showError: Bool) -> Bool {
        
        if data != nil{
            
            let json = JSON(data!)
            let errorCode = json["errorCode"].intValue
            
            // Only show Error Message if no error code
            if errorCode == 0{
                
                return true
                
            }else {
                
                if showError == true {
                    //                    GM.showAlert(message: json["message"].stringValue)
                }
                
                return false
            }
            
            
        }else {
            
            return false
        }
    }
    
    
    // MARK:
    
    // MARK: -- MasterData
    
    func getMasterData(completed: @escaping completionHandler) {
        sendJSONRequest(method: .get, path: Router.GetPostData(), parameters: nil) { (apiResponseHandler, error) -> Void in

//            if let response = Mapper<PostData>().mapArray(JSONObject: apiResponseHandler.jsonObject){
//            print("rep\(response)")
//                let realm = try! Realm()
//                try! realm.write {
//                    realm.delete(realm.objects(PostData.self)) // clear old one
//                    realm.add(response) // add new one
//                }
//            }
            completed(apiResponseHandler, error)
        }
    }
}
struct ApiResponseHandler {
    var success:Bool = false
    var message:String? = nil
    var errorCode:UInt? = nil
    var data:Any? = nil
    var jsonObject:Any? = nil
    
    init(json:Any?) {
        if let js = json {
            self.jsonObject = js
            
            let json = JSON(js)
            self.success = json["Success"].boolValue
            self.message = json["Message"].stringValue
            self.errorCode = UInt(json["ErrorCode"].intValue)
            self.data = json["Data"]
        }
    }
    
    func isSuccess() -> Bool {
        return success == true
    }
    
    func errorMessage() -> String {
        guard message != nil else {
            return "Server Error"
        }
        return message!
    }
}
 


