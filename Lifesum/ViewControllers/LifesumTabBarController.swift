//
//  LifesumTabBarController.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/28/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit
import CoreData

class LifesumTabBarController: UITabBarController, ManagedObjectContextSettable {
    
    enum TabViewControllers: Int {
        case FoodCategories
        case Exercises
    }
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = 0
        guard let foodTabBarItem = tabBar.items?[TabViewControllers.FoodCategories.rawValue] else {fatalError("Tabbar should have items")}
        guard let exerciseTabBarItem = tabBar.items?[TabViewControllers.Exercises.rawValue] else {fatalError("Tabbar should have items")}
        
        foodTabBarItem.image = UIImage(named: "food")
        foodTabBarItem.selectedImage = UIImage(named: "food")?.imageWithRenderingMode(.AlwaysOriginal)
        exerciseTabBarItem.image = UIImage(named: "exercise")
        exerciseTabBarItem.selectedImage = UIImage(named: "exercise")?.imageWithRenderingMode(.AlwaysOriginal)
        
        guard let foodNavigationController = viewControllers?[TabViewControllers.FoodCategories.rawValue] as? UINavigationController else {fatalError("Expected NavigationCOntroller type")}
        guard let headCategoryViewController = foodNavigationController.childViewControllers.first as? HeadCategoryViewController else {fatalError("Expected HeadCategoryViewController type")}
        headCategoryViewController.managedObjectContext = managedObjectContext
        guard let exerciseNavigationController = viewControllers?[TabViewControllers.Exercises.rawValue] as? UINavigationController else {fatalError("Expected NavigationCOntroller type")}
        guard let exercisesViewController = exerciseNavigationController.childViewControllers.first as? ExercisesViewController else {fatalError("Expected ExercisesViewController type")}
        exercisesViewController.managedObjectContext = managedObjectContext
    }
}
