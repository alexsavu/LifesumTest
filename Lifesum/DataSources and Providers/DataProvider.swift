//
//  DataProvider.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit

protocol DataProvider: class {
    typealias Object
//    func objectAtIndexPath(indexPath: NSIndexPath) -> Object
//    func numberOfItemsInSection(section: Int) -> Int
}

//portocol implemented by FetchedResultsDataProvider's delegate used to send the fetched objects
protocol DataProviderDelegate: class {
    typealias Object: AnyObject
    func dataProviderDidReturnWithResults(results:[Object])
}