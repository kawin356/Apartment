//
//  SetBillRoomViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 23/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class SetBillRoomViewController: UIViewController {
    
    var bills: [Bill] = []
    var lastBill: Bill!
    var room: Room!
    var month: String!
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.ReuseCell.billWaterElecCell, bundle: nil), forCellReuseIdentifier: K.ReuseCell.billWaterElecCell)
        let predict = NSPredicate(format: "room == %@", room)
        //let sort = NSSortDescriptor(key: "roomnumber", ascending: true)
        bills = DataController.taskLoadData(type: Bill.self, search: predict, sort: nil)
        
        for bill in bills {
            if bill.date == month {
                lastBill = bill
            }
        }
    }
    
    func getMonth() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let monthCreate = formatter.string(from: date)
        return monthCreate
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        
        let indexPath = IndexPath(row: 0, section: 0)
        let row = tableView.cellForRow(at: indexPath) as! BillCell
        let bill = Bill(context: DataController.shared.viewContext)
        bill.customer = lastBill.customer
        bill.date = getMonth()
        bill.room = room
        bill.haveinternet = row.haveInternetSwitch.isOn
        if let elec = Int(row.newElecTextField.text ?? "0.0") {
            bill.unitelec = Double(exactly: elec)!
        }
        if let water = Int(row.newWaterTextField.text ?? "0.0") {
            bill.unitwater = Double(exactly: water)!
        }
        
        DataController.saveContext()
    }
}


extension SetBillRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.billWaterElecCell, for: indexPath) as! BillCell
        //lastBill = bills[bills.count-1]
        
        if let roomCost = lastBill.room?.roomcost {
            cell.roomCostLabel.text = "Room Cost: \(roomCost) THB/Month"
        }
        if let roomNumber = lastBill.room?.roomnumber {
            cell.roomNumberLabel.text = String(roomNumber)
        }
        if let name = lastBill.customer?.name {
            cell.customerNameLabel.text = name
        }
        
        cell.oldWaterTextField.text = String(lastBill.unitwater)
        cell.oldElecTextField.text = String(lastBill.unitelec)
        
        return cell
    }
    
    
}
