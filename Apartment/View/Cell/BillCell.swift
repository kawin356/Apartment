//
//  BillCell.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 23/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class BillCell: UITableViewCell {

    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var oldWaterTextField: UITextField!
    @IBOutlet weak var oldElecTextField: UITextField!
    @IBOutlet weak var newWaterTextField: UITextField!
    @IBOutlet weak var newElecTextField: UITextField!
    @IBOutlet weak var totalWaterLabel: UILabel!
    @IBOutlet weak var totalElecLabel: UILabel!
    @IBOutlet weak var haveInternetSwitch: UISwitch!
    @IBOutlet weak var roomCostLabel: UILabel!
    @IBOutlet weak var allTotalLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
