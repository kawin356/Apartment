//
//  RoomSetupViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
import CoreData

class RoomSetupViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var numberOfRoom: Int!
    var building: Building!
    var rooms: [Room]?
    var buil: [Building]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.ReuseCell.roomcellNibName, bundle: nil), forCellReuseIdentifier: K.ReuseCell.roomConfigReuseCell)
        
        let fetchRequest:NSFetchRequest<Building> = Building.fetchRequest()
        
        do {
            buil = try DataController.shared.viewContext.fetch(fetchRequest)
            if let bu = buil {
                for b in bu {
                    print(b.name)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
                
    }
    
    @IBAction func nextToCustomerSetup(_ sender: UIBarButtonItem) {
        saveAllRoomSetup()
        performSegue(withIdentifier: K.Segue.customerSetup, sender: nil)
    }
    
    func saveAllRoomSetup() {
        let count = tableView.numberOfRows(inSection: 0)
        
        if checkNull() {
            for selectedRow in 0...count-1 {
                let indexPath = IndexPath(row: selectedRow, section: 0)
                let row = tableView.cellForRow(at: indexPath) as! StartConfigRoomsCell
                let room = Room(context: DataController.shared.viewContext)
                room.roomnumber = row.roomNumberTextField.text
                room.haveFurniture = row.haveFurnitureSwitch.isOn
                room.haveair = row.haveAirconditionSwitch.isOn
                room.roomcost = Double(Int(row.roomCostTextField.text!)!)
                room.building = building
                print(room.roomnumber)
                rooms?.append(room)
                DataController.saveContext()
            }
            
        }
    }
    
    func checkNull() -> Bool {
        let count = tableView.numberOfRows(inSection: 0)
        
        for selectedRow in 0...count-1 {
            let indexPath = IndexPath(row: selectedRow, section: 0)
            let row = tableView.cellForRow(at: indexPath) as! StartConfigRoomsCell
            if row.roomNumberTextField.text == nil || row.roomCostTextField.text == nil {
                print("Please fill all rooms")
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.customerSetup {
            let viewController = segue.destination as! CustomerSetupViewController
            viewController.numberOfRoom = numberOfRoom
            viewController.rooms = rooms
            viewController.building = building
        }
    }
}


extension RoomSetupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRoom
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.roomConfigReuseCell, for: indexPath) as! StartConfigRoomsCell
        cell.roomNumberTextField.text = String(indexPath.row + 100)
        cell.roomCostTextField.text = String(indexPath.row * 1000)
        return cell
    }
}
