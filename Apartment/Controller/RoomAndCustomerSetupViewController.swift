//
//  RoomAndCustomerSetupViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
 
class RoomAndCustomerSetupViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.ReuseCell.roomcellNibName, bundle: nil), forCellReuseIdentifier: K.ReuseCell.roomConfigReuseCell)
        tableView.register(UINib(nibName: K.ReuseCell.customercellNibName, bundle: nil), forCellReuseIdentifier: K.ReuseCell.customerConfigReuseCell)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roomsetting = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.roomConfigReuseCell, for: indexPath)
        let customersetting = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.customerConfigReuseCell, for: indexPath)
        
        switch indexPath.section {
        case 0:
            return roomsetting
        case 1:
            return customersetting
        default:
            break
        }
        return roomsetting
    }
}
