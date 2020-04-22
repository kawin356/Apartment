//
//  CustomerSetupViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
import CoreData

class CustomerSetupViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var numberOfRoom: Int!
    var rooms: [Room]!
    var building: Building!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.ReuseCell.customercellNibName, bundle: nil), forCellReuseIdentifier: K.ReuseCell.customerConfigReuseCell)
        
        let fetchRequest:NSFetchRequest<Room> = Room.fetchRequest()
        let predict = NSPredicate(format: "building == %@", building)
        fetchRequest.predicate = predict
        do {
            rooms = try DataController.shared.viewContext.fetch(fetchRequest)
            for room in rooms {
                print(room.roomnumber)
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func saveCustomerButtonPressed(_ sender: UIButton) {
        saveAllRoomSetup()
        
        let viewController = UIStoryboard(name: K.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: K.StoryboardID.tabbarMain)
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        let window = sceneDelegate.window
        window?.rootViewController = viewController
        
    }
    
    
    func saveAllRoomSetup() {
        let count = tableView.numberOfRows(inSection: 0)
        
        if checkNull() {
            for selectedRow in 0...count-1 {
                let indexPath = IndexPath(row: selectedRow, section: 0)
                let row = tableView.cellForRow(at: indexPath) as! StartConfigCustomerCell
                let customer = Customer(context: DataController.shared.viewContext)
                customer.name = row.nameTextField.text
                customer.room = rooms[indexPath.row]
                customer.telephone = row.telephoneTextField.text
                DataController.saveContext()
            }
            
        }
    }
    
    func checkNull() -> Bool {
        let count = tableView.numberOfRows(inSection: 0)
        for selectedRow in 0...count-1 {
            let indexPath = IndexPath(row: selectedRow, section: 0)
            let row = tableView.cellForRow(at: indexPath) as! StartConfigCustomerCell
            if row.reserveRoomSwitch.isOn {
                if row.nameTextField.text == "" || row.telephoneTextField.text == "" {
                    print("Please fill all rooms")
                    return false
                }
            }
        }
        return true
    }
    
}


extension CustomerSetupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.customerConfigReuseCell, for: indexPath) as! StartConfigCustomerCell
        cell.roomNumberLabel.text = rooms[indexPath.row].roomnumber
        cell.nameTextField.text = "Kitt\(rooms[indexPath.row].roomnumber)"
        cell.telephoneTextField.text = "0191011910\(rooms[indexPath.row].roomnumber)"
        return cell
    }
    
    
}
