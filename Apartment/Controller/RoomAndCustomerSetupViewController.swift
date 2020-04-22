//
//  RoomAndCustomerSetupViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
 
class RoomAndCustomerSetupViewController: UITableViewController {
    
    var room: Room? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.ReuseCell.roomcellNibName, bundle: nil), forCellReuseIdentifier: K.ReuseCell.roomConfigReuseCell)
        tableView.register(UINib(nibName: K.ReuseCell.customercellNibName, bundle: nil), forCellReuseIdentifier: K.ReuseCell.customerConfigReuseCell)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let indexPath = IndexPath(row: 0, section: 0)
        let row = tableView.cellForRow(at: indexPath) as! StartConfigRoomsCell
        let room = Room(context: DataController.shared.viewContext)
        room.roomnumber = row.roomNumberTextField.text
        room.haveFurniture = row.haveFurnitureSwitch.isOn
        room.haveair = row.haveAirconditionSwitch.isOn
        room.roomcost = Double(Int(row.roomCostTextField.text!)!)
        room.building = CurrentBuilding.building
        DataController.saveContext()
        
        let indexPathCustomer = IndexPath(row: 0, section: 1)
        let customer = Customer(context: DataController.shared.viewContext)
        let rowCustomer = tableView.cellForRow(at: indexPathCustomer) as! StartConfigCustomerCell
        if rowCustomer.reserveRoomSwitch.isOn {
            customer.name = rowCustomer.nameTextField.text
            customer.telephone = rowCustomer.telephoneTextField.text
            customer.room = room
        }
        DataController.saveContext()
        
        navigationController?.popViewController(animated: true)
        
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
