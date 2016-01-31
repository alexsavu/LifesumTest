//
//  HeadCategoryCell.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/28/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit

class HeadCategoryCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
}

extension HeadCategoryCell: ConfigurableCell {
    func configureForObject(object: HeadCategory) {
        titleLabel.text = object.title
    }
}
