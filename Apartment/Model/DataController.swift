//
//  DataController.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import CoreData
import UIKit

class DataController {
    
    static let shared = DataController(modelName: "Apartment")
    
    var persistentContainer: NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load() {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    class func saveContext () {
        let context = DataController.shared.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    class func taskLoadData<T: NSManagedObject>(type: T.Type) -> [T] {
        
        let context = DataController.shared.viewContext
           let request = T.fetchRequest()
           do
           {
               let results = try context.fetch(request)
            return results as! [T]
           }
           catch
           {
               print("Error with request: \(error)")
              return []
           }
    }
}


