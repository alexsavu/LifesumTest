//
//  FoodDetailsViewController.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/29/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    
    @IBOutlet private weak var carbsProcentageView: CircleLoadingView!
    @IBOutlet private weak var proteinProcentageView: CircleLoadingView!
    @IBOutlet private weak var fatProcentageView: CircleLoadingView!
    @IBOutlet private weak var caloriesLabel: UILabel!
    
    private var calories: Double = 0
    private var proteinPercentage: Int = 0
    private var carbohydratesPercentage: Int = 0
    private var fatPercentage: Int = 0
    private var totalCalories: Double = 0
    
    var entity: Food! {
        didSet {
            calories = Double(entity.calories)
            totalCalories = totalCaloriesComputation()
            proteinPercentage = calculateMacroPercentage(Double(entity.protein), forFat: false)
            carbohydratesPercentage = calculateMacroPercentage(Double(entity.carbohydrates), forFat: false)
            fatPercentage = calculateMacroPercentage(Double(entity.fat), forFat: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = entity.title
        //setup
        carbsProcentageView.percentage = carbohydratesPercentage
        proteinProcentageView.percentage = proteinPercentage
        fatProcentageView.percentage = fatPercentage
        
        //animate
        startPercentageAnimations()
        
        let attributedString = NSMutableAttributedString(string: "Calories \(calories) kcal")
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Bold", size: 18)!, range: NSMakeRange(0, 8))
        caloriesLabel.attributedText = attributedString
    }
    
    private func startPercentageAnimations() {
        carbsProcentageView.animateProgressView()
        proteinProcentageView.animateProgressView()
        fatProcentageView.animateProgressView()
    }
    
    private func totalCaloriesComputation() -> Double {
        let proteinCalories = 4 * Double(entity.protein)
        let carbsCalories = 4 * Double(entity.carbohydrates)
        let fatCalories = 9 * Double(entity.fat)
        return proteinCalories + carbsCalories + fatCalories
    }
    
    private func calculateMacroPercentage(value: Double, forFat isFat: Bool) -> Int {
        let calorieIndex = Double(isFat ? 9 : 4)
        let percentage = round((calorieIndex * value * 100)/totalCalories)
        return Int(percentage)
    }
}
