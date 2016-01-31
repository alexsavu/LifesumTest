//
//  TableViewDataSource.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit

//the datasource for all tableviews (except the search tableview) and in charge of displaying the relevant info for each viewcontroller
class TableViewDataSource<Delegate: DataSourceDelegate, Data: DataProvider, Cell: UITableViewCell where Delegate.Object == Data.Object, Cell: ConfigurableCell, Cell.DataSource == Data.Object>: NSObject, UITableViewDataSource {
    
    private let tableView: UITableView
    private let dataProvider: Data
    private var results: [Data.Object] = []
    private weak var delegate: Delegate!
    
    init (tableView: UITableView, dataProvider: Data, delegate: Delegate) {
        self.tableView = tableView
        self.delegate = delegate
        self.dataProvider = dataProvider
        super.init()
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    var selectedObject: Data.Object? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        return results[indexPath.row]
    }
    
    func processResults(results: [Data.Object]) {
        self.results = results
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let object = results[indexPath.row]
        let identifier = delegate.cellIdentifierForObject(object)
        guard let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? Cell
            else {fatalError("Unexpected cell type at \(indexPath)")}
        cell.accessoryType = .DisclosureIndicator
        cell.configureForObject(object)
        return cell
    }
}







