//
//  DessertDetailViewModel.swift
//  Fetch-iOSChallenge
//
//  Created by JaredMurray on 7/31/24.
//

import SwiftUI

@Observable
class DessertDetailViewModel {
    var dessertDetails: [DessertDetail] = []
    
    func fetchDessertDetails(dessert id: String) async throws {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }
        let (data, repsonse) = try await URLSession.shared.data(from: url)
        
        //        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        //            handle errors
        //        }
        
        do {
            let decoder = JSONDecoder()
            dessertDetails = try decoder.decode(MealDetails.self, from: data).meals
        } catch {
            print(error.localizedDescription)
            // handle errors
        }
    }
    
    func makeIngredientAndMeasurementDict() {
        
    }
}
