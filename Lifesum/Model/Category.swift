//
//  Category.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import CoreData

final class Category: NSManagedObject {
    @NSManaged private(set) var id: Int16
    @NSManaged private(set) var name: String
    @NSManaged private(set) var headcategoryid: Int16
    @NSManaged private(set) var foods: Set<Food>
    @NSManaged private(set) var headCategory: HeadCategory
    
    static func insertIntoContext(managedObjectContext: NSManagedObjectContext, name: String, id: Int16, headcategoryid: Int16) -> Category {
        let category = findOrCreateCategory(id, inContext: managedObjectContext)
        category.name = name
        category.id = id
        let headCategoryTitle =  MainCategory.RootCategory.nameForHeadCategory(headcategoryid).rawValue
        category.headCategory = HeadCategory.findOrCreateHeadCategory(headCategoryTitle, inContext: managedObjectContext)
        return category
    }
    
    static func findOrCreateCategory(id: Int16, inContext managedObjectContext: NSManagedObjectContext) -> Category{
        let predicate = NSPredicate(format: "id == %d", id)
        let category = findOrCreateInContext(managedObjectContext, matchingPredicate: predicate)
        return category
    }
}

extension Category: ManagedObjectType {
    static var entityName: String {
        return "Category"
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "name", ascending: true)]
    }
    
    static var defaultPredicate: NSPredicate {
        return NSPredicate(format: "%K == NULL", "defaultPredicate")
    }

}
