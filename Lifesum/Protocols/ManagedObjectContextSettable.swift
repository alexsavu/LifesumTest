//
//  ManagedObjectContextSettable.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import CoreData

//Used for passing the moc object
protocol ManagedObjectContextSettable: class {
    var managedObjectContext: NSManagedObjectContext! {get set}
}
