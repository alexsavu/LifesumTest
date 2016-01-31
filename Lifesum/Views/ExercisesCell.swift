//
//  ExercisesCell.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/28/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit

class ExercisesCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
}

extension ExercisesCell: ConfigurableCell {
    func configureForObject(object: Exercise) {
        titleLabel.text = object.title
    }
}