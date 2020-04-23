//
//  BillViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 23/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class BillViewController: UIViewController {
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var tableVIew: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension BillViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
}
