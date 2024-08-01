//
//  DessertListViewModel.swift
//  Fetch-iOSChallenge
//
//  Created by JaredMurray on 7/31/24.
//

import SwiftUI

@Observable
class DessertListViewModel {
    var dessertList: [Dessert] = []
    
    func fetchDessertList() async throws {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        let (data, response) = try await URLSession.shared.data(from: url)
        
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            handle errors
//        }
        
        do {
            let decoder = JSONDecoder()
            let desserts = try decoder.decode(Meals.self, from: data)
            self.dessertList = desserts.meals
        } catch {
            print(error.localizedDescription)
                //handle errors
        }
    }
}
