//
//  ManagedObjectType.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import CoreData

//protocol that every ManagedObject implements for making necesary info available
protocol ManagedObjectType {
    static var entityName: String {get}
    static var defaultSortDescriptors: [NSSortDescriptor] {get}
    static var defaultPredicate: NSPredicate { get }
}

extension ManagedObjectType {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    //sorted fetch request
    static var sortedFetchRequest: NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
    
    //fetch request with custom predicate
    static func sortedFetchRequestWithPredicate(predicate: NSPredicate) -> NSFetchRequest {
        let request = sortedFetchRequest
        request.predicate = predicate
        return request
    }
    
    //search fetch request with custom predicate
    static func sortedFetchRequestForSearchWithPredicate(predicate: NSPredicate) -> NSFetchRequest {
        let request = sortedFetchRequest
        request.predicate = predicate
        return request
    }
}

extension ManagedObjectType where Self: NSManagedObject {
    
    //search for the object in the current context or create one
    static func findOrCreateInContext(managedObjectContext: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self {
        guard let object = findOrFetchInContext(managedObjectContext, matchingPredicate: predicate) else {
            let newObj: Self = managedObjectContext.insertObject()
            return newObj
        }
        return object
    }
    
    //search for the object or fetch it
    static func findOrFetchInContext(managedObjectContext: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
        guard let object = searchForObjectInContext(managedObjectContext, matchingPredicate: predicate) else {
            return fetchInContext(managedObjectContext, matchingPredicate: predicate).first
        }
        return object
    }
    
    //fetch the requested object that matches the predicate
    static func fetchInContext(context: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> [Self] {
        let request = NSFetchRequest(entityName: Self.entityName)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        guard let result = try! context.executeFetchRequest(request) as? [Self] else {fatalError("Fetched objects have wrong type")}
        return result
    }
    
    //search over all registered objects and return one that matches the predicate and is not a fault
    static func searchForObjectInContext(managedObjectContext: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
        for obj in managedObjectContext.registeredObjects where !obj.fault {
            guard let result = obj as? Self where predicate.evaluateWithObject(result) else { continue }
            return result
        }
        return nil
    }
}

