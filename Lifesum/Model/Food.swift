//
//  Food.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import CoreData
import SwiftyJSON

final class Food: NSManagedObject {
    @NSManaged private(set) var title: String
    @NSManaged private(set) var protein: NSNumber
    @NSManaged private(set) var gramsperserving: NSNumber
    @NSManaged private(set) var fat: NSNumber
    @NSManaged private(set) var categoryid: Int16
    @NSManaged private(set) var carbohydrates: NSNumber
    @NSManaged private(set) var calories: Int16
    @NSManaged private(set) var language: String
    @NSManaged private(set) var category: Category
    
    static func extractJSON(array: [AnyObject], moc: NSManagedObjectContext) {
        for jsonDict in array {
            let json = JSON(jsonDict)
            let title = json["title"].stringValue
            let protein = json["protein"].numberValue
            let categoryid = json["categoryid"].int16Value
            let gramsperserving = json["gramsperserving"].numberValue
            let fat = json["fat"].numberValue
            let carbohydrates = json["carbohydrates"].numberValue
            let calories = json["calories"].int16Value
            let language = json["language"].stringValue
            if language == "en_US" {
                Food.insertIntoContext(moc, title: title, categoryid: categoryid, protein: protein, gramsperserving: gramsperserving, fat: fat, carbohydrates: carbohydrates, calories: calories, language: language)
            }
        }
    }
    
    static func insertIntoContext(managedObjectContext: NSManagedObjectContext,
                                                    title: String,
                                                categoryid: Int16,
                                                    protein: NSNumber,
                                            gramsperserving: NSNumber,
                                                        fat: NSNumber,
                                                carbohydrates: NSNumber,
                                                    calories: Int16,
                                                    language: String) -> Food {
        let food = findOrCreateFood(title, inContext: managedObjectContext)
        food.title = title
        food.protein = protein
        food.categoryid = categoryid
        food.gramsperserving = gramsperserving
        food.fat = fat
        food.carbohydrates = carbohydrates
        food.calories = calories
        food.language = language
        food.category = Category.findOrCreateCategory(categoryid, inContext: managedObjectContext)
        return food
    }
    
    static func findOrCreateFood(title: String, inContext managedObjectContext: NSManagedObjectContext) -> Food {
        let predicate = NSPredicate(format: "title = %@", title)
        let food = findOrCreateInContext(managedObjectContext, matchingPredicate: predicate)
        return food
    }
}

extension Food: ManagedObjectType {
    static var entityName: String {
        return "Food"
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true)]
    }
    
    static var defaultPredicate: NSPredicate {
        return NSPredicate(format: "%K == NULL", "defaultPredicate")
    }
}
