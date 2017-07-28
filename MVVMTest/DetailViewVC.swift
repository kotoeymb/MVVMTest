//
//  DetailViewVC.swift
//  MVVMTest
//
//  Created by Toe Wai Aung on 7/28/17.
//  Copyright © 2017 kotoeymb. All rights reserved.
//

import UIKit

class DetailViewVC: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bodytext: UILabel!
    var titleString:String = ""
    var bodyString:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleText.text = titleString
        self.bodytext.text = bodyString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
