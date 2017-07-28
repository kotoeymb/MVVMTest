//
//  postModel.swift
//  MVVMTest
//
//  Created by Toe Wai Aung on 7/27/17.
//  Copyright © 2017 kotoeymb. All rights reserved.
//

import Foundation
import Foundation
import RealmSwift
import ObjectMapper
import SwiftyUserDefaults


class postModel{
    
    var appId : Int?
    var userId : Int?
    var title : String?
    var body : String?
    
    func getCustomiseSettings(success: @escaping (Void) -> Void, failure: @escaping (_ errorMessage: String) -> Void){
        
            APIManager.sharedInstance.getMasterData(completed: { (apiResponseHandler, error) in
//                if !apiResponseHandler.isSuccess() {
            
                    if let response = Mapper<PostData>().mapArray(JSONObject: apiResponseHandler.jsonObject) {
                       print(response)
//                        if let data = response.title{
                        
                            let realm = try! Realm()
                            
                            try! realm.write {
                                realm.delete(realm.objects(PostData.self))
                                realm.add(response)
                            }
                            
//                        }
                    success()
                    
                }else{
                    
                    failure(apiResponseHandler.errorMessage())
                    }
//                }
            })
            
//        }
    }
    
}
