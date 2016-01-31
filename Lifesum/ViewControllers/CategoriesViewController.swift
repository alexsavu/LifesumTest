//
//  CategoriesViewController.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/23/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController, ManagedObjectContextSettable {

    @IBOutlet private weak var tableView: UITableView!
    var managedObjectContext: NSManagedObjectContext!
    var listSource: ListSource!
    var listSourceTitle: ListSourceTitle!
    
    private typealias Data = FetchedResultsDataProvider<CategoriesViewController>
    private var dataSource: TableViewDataSource<CategoriesViewController, Data, CategoryCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = listSourceTitle.title
        setupTableView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let viewController = segue.destinationViewController as? FoodListViewController else {fatalError("expected food list view controller")}
        viewController.managedObjectContext = managedObjectContext
        guard let category = dataSource?.selectedObject else { fatalError("datasource object must not be nil") }
        viewController.listSource = .Category(category.id)
        viewController.listSourceTitle = .Category(category.name)
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        let request = Category.sortedFetchRequestWithPredicate(listSource.predicate)
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 20
        let dataProvider = FetchedResultsDataProvider(request: request, managedObjectContext: managedObjectContext, delegate: self)
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
    }
}

extension CategoriesViewController: DataProviderDelegate {
    
    func dataProviderDidReturnWithResults(results: [Category]) {
        dataSource.processResults(results)
    }
}

extension CategoriesViewController: DataSourceDelegate {
    func cellIdentifierForObject(object: Category) -> String {
        return String(CategoryCell)
    }
}

