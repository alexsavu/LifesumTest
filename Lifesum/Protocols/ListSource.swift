//
//  ListSource.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/27/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import CoreData

//used to pass the necesary data between view controllers
enum ListSource {
    case HeadCategory(Int16)
    case Category(Int16)
}

enum ListSourceTitle {
    case HeadCategory(String)
    case Category(String)
}

extension ListSource {
    var predicate: NSPredicate {
        switch self {
        case .HeadCategory(let id):
            return NSPredicate(format: "headCategory.headcategoryid = %d", id)
        case .Category(let id):
            return NSPredicate(format: "category.id = %d", id)
        }
    }
}

extension ListSourceTitle {
    var title: String {
        switch self {
        case .HeadCategory(let title):
            return title
        case .Category(let title):
            return title
        }
    }
}
