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
    var hasError = false
    var contentError: FICError = .invalidData
    
    func fetchDessertList() async throws {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FICError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            dessertList = try decoder.decode(Meals.self, from: data).meals
            dessertList.sort {
                $0.dessertName < $1.dessertName
            }
        } catch {
            throw FICError.invalidData
        }
    }
}
