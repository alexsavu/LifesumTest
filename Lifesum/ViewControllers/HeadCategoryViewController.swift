//
//  HeadCategoryViewController.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/28/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit
import CoreData

class HeadCategoryViewController: UIViewController, ManagedObjectContextSettable {
    
    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet private weak var tableView: UITableView!
    
    private typealias Data = FetchedResultsDataProvider<HeadCategoryViewController>
    private var dataSource: TableViewDataSource<HeadCategoryViewController, Data, HeadCategoryCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        setupTableView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let viewController = segue.destinationViewController as? CategoriesViewController else {fatalError("expected food list view controller")}
        viewController.managedObjectContext = managedObjectContext
        guard let headCategory = dataSource?.selectedObject else { fatalError("datasource object must not be nil") }
        viewController.listSource = .HeadCategory(headCategory.headcategoryid)
        viewController.listSourceTitle = .HeadCategory(headCategory.title)
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        let request = HeadCategory.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 20
        let dataProvider = FetchedResultsDataProvider(request: request, managedObjectContext: managedObjectContext, delegate: self)
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
        
    }
}

extension HeadCategoryViewController: DataProviderDelegate {
    
    func dataProviderDidReturnWithResults(results: [HeadCategory]) {
        dataSource.processResults(results)
    }
}

extension HeadCategoryViewController: DataSourceDelegate {
    func cellIdentifierForObject(object: HeadCategory) -> String {
        return String(HeadCategoryCell)
    }
}





