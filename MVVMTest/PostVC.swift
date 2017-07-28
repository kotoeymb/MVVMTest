//
//  PostVC.swift
//  MVVMTutorial
//
//  Created by Toe Wai Aung on 7/25/17.
//  Copyright © 2017 kotoeymb. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper

class PostVC: UIViewController {
    var postData : PostData!
    var postSettingData : Results<PostData>!
    var viewModel = postModel()
    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.getAPIManger()
//       self.postSettingData = PostData.getSettings()
// APIManager.sharedInstance.getMasterData(data: data, completed: { (apiResponseHandler, error) in
        getCustomiseSettings() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func getCustomiseSettings(){
        
        viewModel.getCustomiseSettings(success: { _ in
            
            self.postSettingData = PostData.getSettings()
            self.postData = PostData.postSettings()
            print("\(self.postData)")
            self.tbView.reloadData()
//            self.savePostObj()
            
        
        }) { (errorMessage) in
            
        }
    }

}
extension PostVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if postSettingData == nil{
            return 0
        }
        return postSettingData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat
    {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell:GetPostDataTableViewCell = tbView.dequeueReusableCell(withIdentifier: "GetDataCell") as! GetPostDataTableViewCell
        
        let dataPost = postSettingData[indexPath.row]
        print("asdfaaf\(postSettingData)")
        self.postData = dataPost
//        cell.lblTitle.text = postData.debugDescription
        cell.lblBody.text = dataPost.description
        print("\(dataPost.title)")
        print("\(dataPost.body)")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:GetPostDataTableViewCell = tableView.cellForRow(at: indexPath) as! GetPostDataTableViewCell
        //        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        //
        //        label.font = UIFont.boldSystemFontOfSize(16.0)
        if (indexPath.row == 0)
        {
            //            cell.lblLanguage.font = UIFont.boldFont(ofSize: 16.0)
        }
        //        cell.lblLanguage.font = UIFont.boldSystemFont(ofSize: 16.0)
        //        let weight = (indexPath.row % 2 == 0) ? UIFontWeightBold : UIFontWeightRegular
        //        let font = UIFont.systemFont(ofSize: 13, weight: weight)
        //        cell.productName.font = font
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:GetPostDataTableViewCell = tableView.cellForRow(at: indexPath) as! GetPostDataTableViewCell
        // tableView.reloadData()
        if (indexPath.row == 0)
        {
        }
    }
}
