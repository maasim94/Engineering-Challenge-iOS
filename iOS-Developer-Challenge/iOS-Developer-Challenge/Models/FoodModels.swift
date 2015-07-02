//
//  FoodModels.swift
//  iOS-Developer-Challenge
//
//  Created by M.Arslan Asim on 02/07/2015.
//  Copyright (c) 2015 Arslan Asim. All rights reserved.
//

import UIKit
import RealmSwift

class  NutrientsDetailsModel:Object {
    dynamic var unit: String = ""
    dynamic var value: Double = 0.0
}


class ImportantModel:Object
{
    dynamic var dietary_fibre: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var saturated: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var total_carbs: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var sodium: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var potassium: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var polyunsaturated: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var calories: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var sugar: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var monounsaturated: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var cholesterol: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var protein: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var trans: NutrientsDetailsModel = NutrientsDetailsModel()
    dynamic var total_fats: NutrientsDetailsModel = NutrientsDetailsModel()

    


}


class PortionsModel:Object
{
    dynamic var name = ""
    dynamic var important : ImportantModel = ImportantModel()
}

class FoodModel:Object
{
    dynamic var name = ""
    dynamic var _id  = ""

    let portions = List <PortionsModel> ()
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}

