//
//  FoodListCell.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/27/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit

class FoodListCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
}

extension FoodListCell: ConfigurableCell {
    func configureForObject(object: Food) {
        titleLabel.text = object.title
    }
}
