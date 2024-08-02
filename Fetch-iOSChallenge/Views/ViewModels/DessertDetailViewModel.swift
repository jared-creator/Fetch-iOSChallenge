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
    var ingredientsAndMeasurements: [String: String] = [:]
    
    var dessertImage: Image?
    var dessertImageIsLoading = true
    
    let columns = [ GridItem(.flexible()) ]
    var detailSelection: DetailSelection = .ingredients
    
    private var ingredients: [String] = []
    private var measurements: [String] = []
    
    func fetchDessertDetails(dessert id: String) async throws {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }
        let (data, repsonse) = try await URLSession.shared.data(from: url)
        
        //        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        //            handle errors
        //        }
        
        do {
            let decoder = JSONDecoder()
            dessertDetails = try decoder.decode(MealDetails.self, from: data).meals
            makeIngredientAndMeasurementDict()
        } catch {
            print(error.localizedDescription)
            // handle errors
        }
    }
    
    func makeIngredientAndMeasurementDict() {
        var index = 0
        
        //loop through the selected dessert in order to gather the ingredient and measurement details
        for detail in dessertDetails {
            //compactMap to handle nil values //filter to handle empty strings "" & " " (spacing) both handled
            ingredients = detail.getIngredients().compactMap({$0}).filter({$0 != " " && $0 != ""})
            measurements = detail.getMeasurements().compactMap({$0}).filter({$0 != " " && $0 != ""})
        }
        
        //create a dictionary assigning the measurements to the appropiate ingredient
        guard ingredients.count == measurements.count else { return }
        for _ in 0..<ingredients.count {
            ingredientsAndMeasurements[ingredients[index]] = measurements[index]
            index += 1
        }
    }
    
    //not needed but made the ui look better and I had extra time
    func fetchImage(picture url: String) async throws {
        do {
            guard let url = URL(string: url) else { return }
            let (data, response) = try await URLSession.shared.data(from: url)
            let uiImage = UIImage(data: data)!
            dessertImage = Image(uiImage: uiImage)
            dessertImageIsLoading.toggle()
        } catch {
            print(error.localizedDescription)
        }
    }
}

enum DetailSelection: String {
    case ingredients, instructions
}
