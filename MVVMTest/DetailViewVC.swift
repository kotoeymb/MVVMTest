//
//  DetailViewVC.swift
//  MVVMTest
//
//  Created by Toe Wai Aung on 7/28/17.
//  Copyright © 2017 kotoeymb. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewVC: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bodytext: UILabel!
    var titleString:String = ""
    var bodyString:String = ""
    var toDeleteData : PostData!
//    var deleteid = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleText.text = titleString
        self.bodytext.text = bodyString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        let realm = try! Realm()
      
        try! realm.write {
            realm.delete(toDeleteData)
//            realm.add(toDeleteData, update: true)
        }
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
}

