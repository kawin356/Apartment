//
//  StartConfigCustomerCell.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class StartConfigCustomerCell: UITableViewCell {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var reserveRoomSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func reserveRoomChanged(_ sender: UISwitch) {
        nameTextField.isEnabled = sender.isOn
        telephoneTextField.isEnabled = sender.isOn
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
