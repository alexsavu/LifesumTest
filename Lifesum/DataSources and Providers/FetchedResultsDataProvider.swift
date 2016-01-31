//
//  FetchedResultsDataProvider.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import CoreData
import Foundation

//object in charged to making all the async fetch requests(except for the search ones)
class FetchedResultsDataProvider<Delegate: DataProviderDelegate>: NSObject, NSFetchedResultsControllerDelegate, DataProvider {
    
    typealias Object = Delegate.Object
    private weak var delegate: Delegate!
    
    init(request: NSFetchRequest, managedObjectContext: NSManagedObjectContext, delegate: Delegate) {
        self.delegate = delegate
        super.init()
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { (asynchronousFetchResult) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.processAsynchronousFetchResult(asynchronousFetchResult)
            })
        }
        try! managedObjectContext.executeRequest(asyncRequest)
    }

    
    private func processAsynchronousFetchResult(asynchronousFetchResult: NSAsynchronousFetchResult) {
        if let result = asynchronousFetchResult.finalResult {
            // Update Items
            guard let items = result as? [Object] else {fatalError("Object type did not match expected")}
            delegate.dataProviderDidReturnWithResults(items)
        }
    }
}
