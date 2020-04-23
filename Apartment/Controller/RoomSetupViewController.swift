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
    var rooms: [Room] = []
    var buil: [Building]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.ReuseCell.roomcellNibName, bundle: nil), forCellReuseIdentifier: K.ReuseCell.roomConfigReuseCell)
        
   //     let fetchRequest:NSFetchRequest<Building> = Building.fetchRequest()
        
//        do {
//            buil = try DataController.shared.viewContext.fetch(fetchRequest)
//            if let bu = buil {
//                for b in bu {
//                    print(b.name)
//                }
//            }
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
//
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let building = CurrentBuilding.building else { return }
        let predict = NSPredicate(format: "building == %@", building)
        let sort = NSSortDescriptor(key: "roomnumber", ascending: true)
        rooms = DataController.taskLoadData(type: Room.self, search: predict, sort: sort)
        print(rooms.count)
        tableView.reloadData()
        
    }
    
    func checkFinishAll() -> Bool {
        let count = tableView.numberOfRows(inSection: 0)
        for selectedRow in 0...count-1 {
            let indexPath = IndexPath(row: selectedRow, section: 0)
            let row = tableView.cellForRow(at: indexPath)
            if row?.backgroundColor == .red {
                print("Please fill all rooms")
                return false
            }
        }
        return true
    }
    
    @IBAction func nextToCustomerSetup(_ sender: UIBarButtonItem) {
//        saveAllRoomSetup()
//        performSegue(withIdentifier: K.Segue.customerSetup, sender: nil)
        if checkFinishAll() {
            let viewController = UIStoryboard(name: K.StoryboardID.main, bundle: nil).instantiateViewController(withIdentifier: K.StoryboardID.tabbarMain)
            let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            let window = sceneDelegate.window
            window?.rootViewController = viewController
        } else {
            let alertVC = UIAlertController(title: "Incomplete", message: "Please input information !", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(action)
            present(alertVC, animated: true, completion: nil)
        }
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
                rooms.append(room)
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
        
//        if segue.identifier == K.Segue.toSettingRoomAndCustomer {
//            let viewController = segue.destination as! RoomAndCustomerSetupViewController
//            if let indexPath = tableView.indexPathForSelectedRow {
//                //viewController.room = tableView.row
//            }
//        }
    }
}


extension RoomSetupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRoom
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.roomConfigReuseCell, for: indexPath) as! StartConfigRoomsCell
//        cell.roomNumberTextField.text = String(indexPath.row + 100)
//        cell.roomCostTextField.text = String(indexPath.row * 1000)
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.roomdetailReuseCell, for: indexPath)
        print("\(rooms.count) >< \(indexPath.row)")
        if rooms.count > indexPath.row,let roomnumber = rooms[indexPath.row].roomnumber {
            cell.textLabel?.text = roomnumber
            cell.detailTextLabel?.text = "Complete"
            cell.backgroundColor = .green
        } else {
            cell.textLabel?.text = String(indexPath.row)
            cell.detailTextLabel?.text = "Need information"
            cell.backgroundColor = .red
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Segue.toSettingRoomAndCustomer, sender: self)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("finishEdit")
    }
    
}
