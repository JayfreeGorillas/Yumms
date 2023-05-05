//
//  IngredientModel.swift
//  Yumms
//
//  Created by Josfry Barillas on 5/1/23.
//

import Foundation

// 
struct Ingredients {
    var ingredient: String
    var measureMent: String
}

struct DessertModel {
    var name: String
    var area: String
    var instructions: String
    var ingredients: [Ingredients]
}
