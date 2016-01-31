//
//  CatogoryCell.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
}

extension CategoryCell: ConfigurableCell {
    func configureForObject(object: Category) {
        titleLabel.text = object.name
    }
}
