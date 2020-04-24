//
//  SettingViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 24/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func removeAllBillsBottonPressed(_ sender: UIButton) {
        
                DataController.taskDeleteAllEntity(type: Bill.self)
                DataController.saveContext()
    }
    
}
