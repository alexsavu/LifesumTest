//
//  FoodListViewController.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/27/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class FoodListViewController: UIViewController, ManagedObjectContextSettable {
    
    var managedObjectContext: NSManagedObjectContext!
    var listSource: ListSource!
    var listSourceTitle: ListSourceTitle!
    @IBOutlet private weak var tableView: UITableView!
    
    private typealias Data = FetchedResultsDataProvider<FoodListViewController>
    private var dataSource: TableViewDataSource<FoodListViewController, Data, FoodListCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = listSourceTitle.title
        setupTableView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let viewController = segue.destinationViewController as? FoodDetailsViewController else {fatalError("expected food list view controller")}
        guard let food = dataSource?.selectedObject else { fatalError("datasource object must not be nil") }
        viewController.entity = food
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        let request = Food.sortedFetchRequestWithPredicate(listSource.predicate)
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 20
        let dataProvider = FetchedResultsDataProvider(request: request, managedObjectContext: managedObjectContext, delegate: self)
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
    }
}

extension FoodListViewController: DataProviderDelegate {
    
    func dataProviderDidReturnWithResults(results: [Food]) {
        dataSource.processResults(results)
    }
}

extension FoodListViewController: DataSourceDelegate {
    func cellIdentifierForObject(object: Food) -> String {
        return String(FoodListCell)
    }
}
