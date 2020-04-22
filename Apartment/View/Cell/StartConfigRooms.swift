//
//  StartConfigRooms.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class StartConfigRooms: UITableViewCell {
    @IBOutlet weak var roomNumberTextField: UITextField!
    @IBOutlet weak var haveFurnitureSwitch: UISwitch!
    @IBOutlet weak var haveAirconditionSwitch: UISwitch!
    @IBOutlet weak var roomCostTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
