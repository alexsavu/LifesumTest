//
//  DataSource.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

//implemented by the TableViewDataSource's delegate
protocol DataSourceDelegate: class {
    typealias Object
    func cellIdentifierForObject(object: Object) -> String
}
