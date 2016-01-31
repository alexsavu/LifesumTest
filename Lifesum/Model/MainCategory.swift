//
//  MainCategory.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/28/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//


struct MainCategory {
    enum RootCategory: String {
        case BreadBakery = "Bread & Bakery"
        case Meat = "Meat"
        case FishAndShellfish = "Fish & shellfish"
        case FruitAndNuts = "Fruit & nuts"
        case Vegetables = "Vegetables"
        case DairyAndEggs = "Dairy & Eggs"
        case Drinks = "Drinks"
        case Snaks = "Snaks, candy & dessert"
        case ReadyMeals = "Ready meals"
        case FoodCupboard = "Food cupboard"
        case Sauces = "Sauces & soup"
        case Beef = "Beef"
        case Pork = "Pork"
        case Veal = "Veal"
        case Lamb = "Lamb"
        case Unknown = "Unknown"
    }
}

extension MainCategory.RootCategory {
    static func nameForHeadCategory(headCategoryId: Int16) -> MainCategory.RootCategory {
        switch headCategoryId {
        case 4:
            return .BreadBakery
        case 5:
            return .Meat
        case 6:
            return .FishAndShellfish
        case 7:
            return .FruitAndNuts
        case 8:
            return .Vegetables
        case 9:
            return .DairyAndEggs
        case 10:
            return .Drinks
        case 11:
            return .Snaks
        case 12:
            return .ReadyMeals
        case 13:
            return .FoodCupboard
        case 14:
            return .Sauces
        case 16:
            return .Beef
        case 17:
            return .Pork
        case 18:
            return .Veal
        case 19:
            return .Lamb
        default:
            return .Unknown
        }
    }
}
