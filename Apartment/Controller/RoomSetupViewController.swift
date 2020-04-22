//
//  RoomSetupViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class RoomSetupViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.ReuseCell.roomcellNibName, bundle: nil), forCellReuseIdentifier: K.ReuseCell.roomConfigReuseCell)
    }
}


extension RoomSetupViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.roomConfigReuseCell, for: indexPath) as! StartConfigRoomsCell
        
        return cell
    }
    
    
}
