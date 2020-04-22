//
//  MainRoomTableView.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class MainRoomTableView: UIViewController {
    
    var rooms: [Room] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.ReuseCell.tableCustomNibName, bundle: nil), forCellReuseIdentifier: K.ReuseCell.customTableReuseCell)
        
        guard let building = CurrentBuilding.building else { return }
               let predict = NSPredicate(format: "building == %@", building)
               let sort = NSSortDescriptor(key: "roomnumber", ascending: true)
               rooms = DataController.taskLoadData(type: Room.self, search: predict, sort: sort)
        
    }
}


extension MainRoomTableView: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseCell.customTableReuseCell, for: indexPath) as! CustomerDetailCell
        if let name = rooms[indexPath.row].customer?.name {
            cell.nameLabel.text = name
        } else {
            cell.nameLabel.text = "-"
        }
        
        cell.roomNumberLabel.text = rooms[indexPath.row].roomnumber
        
        if rooms[indexPath.row].haveair {
            cell.airConditionImageView.isHidden = false
        } else {
            cell.airConditionImageView.isHidden = true
        }
        
        if rooms[indexPath.row].haveFurniture {
            cell.furnitureImageView.isHidden = false
        } else {
            cell.furnitureImageView.isHidden = true
        }
        
        cell.costLabel.text = "Room Cost: \(rooms[indexPath.row].roomcost) THB/Month"
        
        return cell
    }
    
    
}
