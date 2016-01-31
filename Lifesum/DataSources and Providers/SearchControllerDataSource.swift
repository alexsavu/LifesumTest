//
//  SearchControllerDataSource.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/30/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit
import CoreData

//the delegate for the search bar and the search tableview in charge of extracting the search criteria, fetching the search results and displaying them
class SearchControllerDataSource<Delegate: SearchDataSourceDelegate, Cell: UITableViewCell where Cell: ConfigurableCell, Cell.DataSource == Delegate.Object>: NSObject, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDataSource {
    
    private var searchTableView: UITableView
    private var mainTableView: UITableView
    private let searchController = UISearchController(searchResultsController: nil)
    private let moc: NSManagedObjectContext
    private weak var delegate: Delegate!
    typealias Object = Delegate.Object
    private var results: [Delegate.Object] = [] {
        didSet{
            searchTableView.reloadData()
        }
    }
    
    init(searchTableView: UITableView, tableView: UITableView, managedObjectContext: NSManagedObjectContext, delegate: Delegate) {
        self.searchTableView = searchTableView
        self.mainTableView = tableView
        self.moc = managedObjectContext
        self.delegate = delegate
        super.init()
        
        // Setup the Search Controller, UISearchBar and UITableView delegates
        self.searchController.loadViewIfNeeded()
        self.searchController.searchBar.delegate = self
        self.searchTableView.dataSource = self
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.autocapitalizationType = .None
        self.searchController.searchBar.placeholder = "Search for exercises"
        
        // add search bar to the main tableview
        tableView.tableHeaderView = searchController.searchBar
    }

    private func fetchRequestForSearch(searchedText: String?) {
        guard let searchedString = searchedText where searchedText != "" else {return}
        
        // build the predicate for the search fetch request
        let predicate = NSPredicate(format: "%K BEGINSWITH[n] %@", Exercise.normalizedTitleKey, searchedString.normalizedForSearch)
        let request = Exercise.sortedFetchRequestForSearchWithPredicate(predicate)
        
        //asynchronious fetch request
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { (asynchronousFetchResult) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.processAsynchronousFetchResult(asynchronousFetchResult)
            })
        }
        try! moc.executeRequest(asyncRequest)
    }
    
    private func processAsynchronousFetchResult(asynchronousFetchResult: NSAsynchronousFetchResult) {
        if let result = asynchronousFetchResult.finalResult {
            // Update Items
            guard let items = result as? [Object] else {fatalError("Object type did not match expected")}
            self.results = items
        }
    }
    
    //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        mainTableView.hidden = false
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        mainTableView.hidden = true
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        fetchRequestForSearch(searchController.searchBar.text)
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let object = results[indexPath.row]
        let identifier = delegate.cellSearchIdentifierForObject(object)
        guard let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? Cell
            else {fatalError("Unexpected cell type at \(indexPath)")}
        cell.selectionStyle = .None
        cell.configureForObject(object)
        return cell
    }
}
