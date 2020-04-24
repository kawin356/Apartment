//
//  BillViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 23/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class BillViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var rooms: [Room] = []
    var customers: [Customer] = []
    var bills: [Bill] = []
    
    
    var monthBill: [String] = []
    var dateAll: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()     
        guard let building = CurrentBuilding.building else { return }
        let predict = NSPredicate(format: "building == %@", building)
        let sort = NSSortDescriptor(key: "roomnumber", ascending: true)
        rooms = DataController.taskLoadData(type: Room.self, search: predict, sort: sort)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        monthBill = []
        super.viewDidAppear(animated)
        datePicker.reloadAllComponents()
    }
    
    @IBAction func createNewBillBarButtonPressed(_ sender: UIBarButtonItem) {
        createBill()
        // goto set water and elec
        datePicker.reloadAllComponents()
        tableView.reloadData()
    }
    
    func getMonth() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let monthCreate = formatter.string(from: date)
        return monthCreate
    }
    
    func createBill() {
        for room in rooms {
            let newBill = Bill(context: DataController.shared.viewContext)
            newBill.date = getMonth()//currentDate!
            newBill.customer = room.customer
            newBill.room = room
            DataController.saveContext()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.toSetupBill {
            let viewController = segue.destination as! SetBillRoomViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                viewController.room = rooms[indexPath.row]
                viewController.month = monthBill[datePicker.selectedRow(inComponent: 0)]
            }
        }
    }
    
    
}

extension BillViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.billTableReuseCell, for: indexPath)
        print("\(rooms.count) >< \(indexPath.row)")
        if rooms.count > indexPath.row,let roomnumber = rooms[indexPath.row].roomnumber {
            cell.textLabel?.text = roomnumber
            cell.detailTextLabel?.text = "Please input water and elec"
            //cell.backgroundColor = .green
        } else {
            cell.textLabel?.text = String(indexPath.row)
            cell.detailTextLabel?.text = "Need information"
            //cell.backgroundColor = .red
        }
        return cell
    }
    
    
    
}

extension BillViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //(Month,Year)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //        guard let building = CurrentBuilding.building else { return 0 }
        //        let predict = NSPredicate(format: "building == %@", building)
        //        let sort = NSSortDescriptor(key: "roomnumber", ascending: true)
        var date: [String] = []
        bills = DataController.taskLoadData(type: Bill.self, search: nil, sort: nil)
        for billdate in bills {
            date.append(billdate.date ?? getMonth())
        }
        dateAll = Array(Set(date))
        for month in dateAll {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            monthBill.append(month)
        }
        monthBill = Array(Set(monthBill))
        return monthBill.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return monthBill[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(dateAll.count)
        for date in dateAll {
            print(date)
        }
    }
    
}


extension Array where Element : Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}
