//
//  FoodModel.swift
//  Fetch-iOSChallenge
//
//  Created by JaredMurray on 7/31/24.
//

import Foundation

struct Meals: Codable {
    var meals: [Dessert]
}

struct Dessert: Codable {
    var dessertName: String
    var dessertPictureURL: String
    var dessertID: String
    
    enum CodingKeys: String, CodingKey {
        case dessertName = "strMeal"
        case dessertPictureURL = "strMealThumb"
        case dessertID = "idMeal"
    }
}
