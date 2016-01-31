//
//  HeadCategory.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/28/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import CoreData

final class HeadCategory: NSManagedObject {
    @NSManaged private(set) var title: String
    @NSManaged private(set) var headcategoryid: Int16
    @NSManaged private(set) var categories: Set<Category>
    
    static func insertIntoContext(managedObjectContext: NSManagedObjectContext, title: String, headcategoryid: Int16) -> HeadCategory {
        let headCategory = findOrCreateHeadCategory(title, inContext: managedObjectContext)
        headCategory.title = title
        headCategory.headcategoryid = headcategoryid
        return headCategory
    }
    
    static func findOrCreateHeadCategory(title: String, inContext managedObjectContext: NSManagedObjectContext) -> HeadCategory {
        let predicate = NSPredicate(format: "title = %@", title)
        let headCategory = findOrCreateInContext(managedObjectContext, matchingPredicate: predicate)
        return headCategory
    }
}

extension HeadCategory: ManagedObjectType {
    static var entityName: String {
        return "HeadCategory"
    }
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true)]
    }
    
    static var defaultPredicate: NSPredicate {
        return NSPredicate(format: "%K == NULL", "defaultPredicate")
    }
}