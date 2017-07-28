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
        getCustomiseSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    func getCustomiseSettings(){
        
        viewModel.getCustomiseSettings(success: { _ in
            
            self.postSettingData = PostData.getSettings()
            self.tbView.reloadData()
        
        }) { (errorMessage) in
            
        }
    }
    @IBAction func buttonClicked(_ sender: Any) {
        
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
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell:GetPostDataTableViewCell = tbView.dequeueReusableCell(withIdentifier: "GetDataCell") as! GetPostDataTableViewCell
        
        let dataPost = postSettingData[indexPath.row]

        cell.lblBody.text = dataPost["body"] as? String
        cell.lblTitle.text = dataPost["title"] as? String
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:GetPostDataTableViewCell = tableView.cellForRow(at: indexPath) as! GetPostDataTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewVC") as? DetailViewVC{
            if let tipTitle = cell.lblTitle.text{
                vc.titleString = tipTitle
            }
            if let tipBody = cell.lblBody.text{
                vc.bodyString = tipBody
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
//          present(vc, animated: true, completion: nil)

        }
    }
    
}
