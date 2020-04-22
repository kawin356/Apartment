//
//  WelcomeViewController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
import CoreData

class WelcomeViewController: UIViewController {
    
    var rooms: [Room] = []
    var building: [Building] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkAlreadyCreateBuilding()
    }
    
    func checkAlreadyCreateBuilding() {
        let building = DataController.taskLoadData(type: Building.self, search: nil, sort: nil)
        print("Building count \(building.count)")
        if building.count == 0 {
            print("Go To Create")
        } else {
            CurrentBuilding.building = building[0]
            self.performSegue(withIdentifier: K.Segue.toMain, sender: nil)
        }
    }
}
