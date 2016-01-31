//
//  ExercisesViewController.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/28/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit
import CoreData

class ExercisesViewController: UIViewController, ManagedObjectContextSettable {
    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchTableView: UITableView!
    
    private typealias Data = FetchedResultsDataProvider<ExercisesViewController>
    private var dataSource: TableViewDataSource<ExercisesViewController, Data, ExercisesCell>!
    private var searchControllerDataSource: SearchControllerDataSource<ExercisesViewController, ExercisesCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Exercises"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        let request = Exercise.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 20
        let dataProvider = FetchedResultsDataProvider(request: request, managedObjectContext: managedObjectContext, delegate: self)
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
        searchControllerDataSource = SearchControllerDataSource(searchTableView: searchTableView, tableView: tableView, managedObjectContext: managedObjectContext, delegate: self)
    }
}

extension ExercisesViewController: DataProviderDelegate {
    
    func dataProviderDidReturnWithResults(results: [Exercise]) {
        dataSource.processResults(results)
    }
}

extension ExercisesViewController: DataSourceDelegate {
    func cellIdentifierForObject(object: Exercise) -> String {
        return String(ExercisesCell)
    }
}

extension ExercisesViewController: SearchDataSourceDelegate {
    func cellSearchIdentifierForObject(object: Exercise) -> String {
        return String(ExercisesCell)
    }
}
