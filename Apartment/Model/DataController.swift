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
    
    class func deleteEntity() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Building")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try DataController.shared.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    class func taskLoadData<T: NSManagedObject>(type: T.Type, search: NSPredicate?, sort: NSSortDescriptor?) -> [T] {
        
        let context = DataController.shared.viewContext
        
        let request = T.fetchRequest()
        
        if let predicate = search {
            request.predicate = predicate
        }
        
        if let sort = sort {
            request.sortDescriptors = [sort]
        }
                
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


