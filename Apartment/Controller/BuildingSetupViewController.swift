//
//  BuildingSetupViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class BuildingSetupViewController: UIViewController {
    @IBOutlet weak var buildingNameTextField: UITextField!
    @IBOutlet weak var numberOfRoomsTextField: UITextField!
    @IBOutlet weak var numberOfFloorsTextField: UITextField!
    @IBOutlet weak var waterCostTextField: UITextField!
    @IBOutlet weak var elecCostTextField: UITextField!
    
    var buildingCurrent: Building?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        DataController.deleteEntity()
        let building = Building(context: DataController.shared.viewContext)
        guard let name = buildingNameTextField.text,
            let room = Int16(numberOfRoomsTextField.text!),
            let costelec = Int16(elecCostTextField.text!),
            let costwater = Int16(waterCostTextField.text!) else {
                print("error")
                return
        }
        building.name = name
        building.numberofrooms = room
        building.costelec = costelec
        building.costwater = costwater
        buildingCurrent = building
        DataController.saveContext()
        CurrentBuilding.building = building
        
        performSegue(withIdentifier: K.Segue.roomSetup, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.roomSetup {
            let viewController = segue.destination as! RoomSetupViewController
            viewController.numberOfRoom = Int(numberOfRoomsTextField.text!)
            viewController.building = buildingCurrent
        }
    }
    
}
