//
//  ViewController.swift
//  DynamicLinkDemo
//
//  Created by Finlitetech on 02/11/18.
//  Copyright © 2018 Finlitetech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl_userId: UILabel!
    var UserID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserID)
        if UserID == ""
        {
            lbl_userId.text = "Profile ID:- No ID"
        }
        else
        {
            lbl_userId.text = "Profile ID:- \(UserID)"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

}

