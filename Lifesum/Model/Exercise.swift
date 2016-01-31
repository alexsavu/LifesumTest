//
//  Exercise.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import CoreData
import SwiftyJSON

final class Exercise: NSManagedObject {
    @NSManaged private(set) var primitiveTitle: String
    @NSManaged private(set) var calories: NSNumber
    var title: String {
        set {
            willChangeValueForKey(Exercise.titleKey)
            primitiveTitle = newValue
            updateNormalizedTitle(newValue)
            didChangeValueForKey(Exercise.titleKey)
        }
        get {
            willAccessValueForKey(Exercise.titleKey)
            let value = primitiveTitle
            didAccessValueForKey(Exercise.titleKey)
            return value
        }
    }
    static let titleKey = "title"
    static let normalizedTitleKey = "title_normalized"
    
    static func extractJSON(array: [AnyObject], moc: NSManagedObjectContext) {
        for jsonDict in array {
            let json = JSON(jsonDict)
            let title = json["title"].stringValue
            let calories = json["calories"].numberValue
            Exercise.insertIntoContext(moc, title: title, calories: calories)
        }
    }
    
    static func insertIntoContext(managedObjectContext: NSManagedObjectContext, title: String, calories: NSNumber) -> Exercise {
        let exercise = findOrCreateExercise(title, inContext: managedObjectContext)
        exercise.title = title
        exercise.calories = calories
        return exercise
    }
    
    //it searches if the entity is in our database. if so it returns it otherwise it inserts it
    static func findOrCreateExercise(title: String, inContext managedObjectContext: NSManagedObjectContext) -> Exercise {
        let predicate = NSPredicate(format: "title = %@", title)
        let exercise = findOrCreateInContext(managedObjectContext, matchingPredicate: predicate)
        return exercise
    }
    
    //setting the normalized title
    private func updateNormalizedTitle(title: String) {
        setValue(title.normalizedForSearch, forKey: Exercise.normalizedTitleKey)
    }
}

extension Exercise: ManagedObjectType {
    static var entityName: String {
        return "Exercise"
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true)]
    }
    
    static var defaultPredicate: NSPredicate {
        return NSPredicate(format: "%K == NULL", "defaultPredicate")
    }
}



