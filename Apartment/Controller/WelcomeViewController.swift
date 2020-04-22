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
       // self.performSegue(withIdentifier: K.Segue.toMain, sender: nil)
    }
    
    func checkAlreadyCreateBuilding() {
        
        let fetchRequest:NSFetchRequest<Building> = Building.fetchRequest()
        do {
             building = try DataController.shared.viewContext.fetch(fetchRequest)
            
            for bui in building {
                print(bui.name)
            }
            
            if building.count == 0 {
                print("Go To Create")
            } else {
                self.performSegue(withIdentifier: K.Segue.toMain, sender: nil)
            }
            
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
