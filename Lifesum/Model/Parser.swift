//
//  Parser.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import SwiftyJSON

class Parser {
    static func getCategoriesJSON() -> [AnyObject]? {
        guard let jsonURL = NSBundle.mainBundle().URLForResource("categoriesStatic", withExtension: "json") else {fatalError("Could not load JSON file")}
        guard let jsonData = NSData(contentsOfURL: jsonURL) else {fatalError("Invalid data")}
        let json = JSON(data: jsonData)
        return json.arrayObject
    }
    
    static func getFoodJSON() -> [AnyObject]? {
        guard let jsonURL = NSBundle.mainBundle().URLForResource("foodStatic", withExtension: "json") else {fatalError("Could not load JSON file")}
        guard let jsonData = NSData(contentsOfURL: jsonURL) else {fatalError("Invalid data")}
        let json = JSON(data: jsonData)
        return json.arrayObject
    }
    
    static func getExerciseJSON() -> [AnyObject]? {
        guard let jsonURL = NSBundle.mainBundle().URLForResource("exercisesStatic", withExtension: "json") else {fatalError("Could not load JSON file")}
        guard let jsonData = NSData(contentsOfURL: jsonURL) else {fatalError("Invalid data")}
        let json = JSON(data: jsonData)
        return json.arrayObject
    }
}