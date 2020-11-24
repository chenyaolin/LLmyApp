//
//  LLDBManager.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2020/10/29.
//  Copyright © 2020 ManlyCamera. All rights reserved.
//

import Foundation
import CoreData

class LLDBManager {
    
    typealias Handler = (_ context: NSManagedObjectContext) -> Void
    
    static let `default` = LLDBManager()
    
    // disk
    let inDiskContainer: NSPersistentContainer
    let viewContext : NSManagedObjectContext
    let privateQueueContext : NSManagedObjectContext
    
    // memory
    let inMemoryContainer : NSPersistentContainer
    let inMemoryContext : NSManagedObjectContext
    
    let inMemoryDescription : NSPersistentStoreDescription = {
        let inMemoryDescription = NSPersistentStoreDescription()
        inMemoryDescription.type = NSInMemoryStoreType
        inMemoryDescription.isReadOnly = false
        return inMemoryDescription
    }()
    
    let inDiskDescription : NSPersistentStoreDescription = {
        let inDiskDescription = NSPersistentStoreDescription()
        inDiskDescription.type = NSBinaryStoreType
        inDiskDescription.isReadOnly = false
        return inDiskDescription
    }()
    
    private init() {
        
        let modelName = "LLFish"
        
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("need a \(modelName).xcdatamodeId momd in bundle")
        }
        
        inDiskContainer = NSPersistentContainer(name: modelName, managedObjectModel: model)
        
        inDiskContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        })
        
        viewContext = inDiskContainer.viewContext
        
        privateQueueContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateQueueContext.parent = viewContext
        
        inMemoryContainer = NSPersistentContainer(name: modelName, managedObjectModel: model)
        inMemoryContainer.persistentStoreDescriptions = [inMemoryDescription]
        inMemoryContainer.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        inMemoryContext = inMemoryContainer.viewContext
        
    }

}

// MARK: - In Disk save handler
extension LLDBManager {
    
    func syncSaveInMain(_ completionHandler: Handler) {
        
        viewContext.performAndWait {
            
            completionHandler(self.viewContext)
            
            saveViewContext()
        }
    }
    
    func asynSaveInMain(_ completionHandler: @escaping Handler) {
        
        viewContext.perform {
            
            completionHandler(self.viewContext)
            
            self.saveViewContext()
        }
    }
    
    func performSyncSave(inPrivate completionHandler: Handler) {
        
        privateQueueContext.performAndWait {
            
            completionHandler(self.privateQueueContext)
            
            savePrivateContext()
        }
    }
    
    func asynSaveInPrivate(_ completionHandler: @escaping Handler) {
        
        privateQueueContext.perform {
            
            completionHandler(self.privateQueueContext)
            
            self.savePrivateContext()
            
            self.viewContext.performAndWait {
                
                self.saveViewContext()
                
            }
        }
    }
    
    func savePrivateContext() {
//        guard privateQueueContext.hasChanges else { return print("none data change") }
        
        do {
            try privateQueueContext.save()
        } catch {
            
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func saveViewContext() {
        
//        guard viewContext.hasChanges else { return print("none data change") }
        
        do {
            try viewContext.save()
        } catch {
            
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
}
