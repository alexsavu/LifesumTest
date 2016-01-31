//
//  AppDelegate.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/23/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let coreDataStore = CoreDataStore()
        let managedObjectContext = coreDataStore.managedObjectContext
         let tabBarController = window?.rootViewController as! ManagedObjectContextSettable //else {fatalError("Expected tab bar view controller type")}
        tabBarController.managedObjectContext = managedObjectContext
        loadCategories(managedObjectContext)
        loadFoods(managedObjectContext)
        loadExercices(managedObjectContext)
        return true
    }
    
    private func loadCategories(moc: NSManagedObjectContext) {
        guard let jsonArray = Parser.getCategoriesJSON() else {fatalError("Can't have a nil object")}
        
        moc.performChanges {
            Category.extractJSON(jsonArray, moc: moc)
        }
    }
    
    private func loadFoods(moc: NSManagedObjectContext) {
        guard let jsonArray = Parser.getFoodJSON() else {fatalError("Failed getting the food json")}
        moc.performChanges {
            Food.extractJSON(jsonArray, moc: moc)
        }
    }
    
    private func loadExercices(moc: NSManagedObjectContext) {
        guard let jsonArray = Parser.getExerciseJSON() else {fatalError("Failed getting the food json")}
        moc.performChanges {
            Exercise.extractJSON(jsonArray, moc: moc)
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

