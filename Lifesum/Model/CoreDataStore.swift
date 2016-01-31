//
//  CoreDataStore.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import CoreData

class CoreDataStore {
    private let ubiquityToken: String = {
        guard let token = NSFileManager.defaultManager().ubiquityIdentityToken else { return "unknown" }
        return NSKeyedArchiver.archivedDataWithRootObject(token).base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
    }()
    
    private lazy var StoreURL: NSURL = {
        return NSURL.documentsURL.URLByAppendingPathComponent("\(self.ubiquityToken).life")
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("Lifesum", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do{
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.StoreURL, options: nil)
        } catch {
            fatalError("Could not load database:\(error)")
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}
