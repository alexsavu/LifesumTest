//
//  ConfigurableCell.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

//protocol that every cell implements for customizing the cell content
protocol ConfigurableCell {
    typealias DataSource
    func configureForObject(object: DataSource)
}
