//
//  TableData.swift
//  MVVMTutorial
//
//  Created by Toe Wai Aung on 7/25/17.
//  Copyright © 2017 kotoeymb. All rights reserved.
//
import Foundation
import RealmSwift
import ObjectMapper
import SwiftyUserDefaults

class PostData: Object, Mappable{
    var userId = "" 
    var appId = ""
    var title = ""
    var body = ""
    
    required convenience init?(map: Map){
       self.init()
    }
    
    func mapping(map: Map) {
//        if map.mappingType == .toJSON {
//            userId >>> map["userId"]
//            appId >>> map["id"]
//            title >>> map["title"]
//            body >>> map["body"]
//        }else{
//            userId <- (map["userId"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
//            appId <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
            userId <- map["userId"]
            appId <- map["id"]

            title <- map["title"]
            body <- map["body"]
    }
    static func getSettings() -> Results<PostData>?{
        let realm = try! Realm()
        return realm.objects(PostData.self)
    }

    static func postSettings() -> PostData{
        let realm = try! Realm()
        return realm.objects(PostData.self).first!
    }
    
    static func getUpdatedpost() -> PostData? {
        let realm = try! Realm()
        return realm.objects(PostData.self).first
    }
}
class PostDataResponse : NSObject,Mappable{
    
    dynamic var postDataResp : PostData?
    required init?(map: Map){
        
}
    
//    override init(){
//        super.init()
//    }
    
    func mapping(map: Map) {
        postDataResp <- map //["PostData"]

    }
}




