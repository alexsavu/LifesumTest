//
//  SearchDataSource.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/30/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

//protocol implemented by the searchcontroller delegate
protocol SearchDataSourceDelegate: class {
    typealias Object: AnyObject
    func cellSearchIdentifierForObject(object: Object) -> String
}
