//
//  DessertDetailView.swift
//  Fetch-iOSChallenge
//
//  Created by JaredMurray on 7/31/24.
//

import SwiftUI

struct DessertDetailView: View {
    @State private var vm = DessertDetailViewModel()
    var dessertID: String
    var dessertImageURL: String
    
    var body: some View {
        ScrollView {
            VStack {
                DessertImage
                InstructionsView
                VStack {
                    IngredientView
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await vm.fetchDessertDetails(dessert: dessertID)
                } catch {
                    
                }
            }
            Task {
                await vm.fetchImage(picture: dessertImageURL)
            }
        }
    }
    
    private var DessertImage: some View {
        vm.dessertImage?
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .padding(.bottom, 30)
    }
    
    private var InstructionsView: some View {
        ScrollView {
            ForEach(vm.dessertDetails, id: \.dessertName) { detail in
                VStack(alignment: .leading, spacing: 10) {
                    Text("Instructions:")
                    Text(detail.dessertInstructions)
                }
            }
            
        }
        .frame(width: 350, height: 300)
    }
    
    private var IngredientView: some View {
        ForEach(vm.ingredientsAndMeasurements.sorted(by: >), id: \.key) { ingredient, measurement in
            HStack(spacing: 20) {
                Text("\(ingredient):")
                Text(measurement)
            }
        }
    }
}

#Preview {
    DessertDetailView(dessertID: "52928", dessertImageURL: "https://www.themealdb.com/images/media/meals/ryppsv1511815505.jpg")
}
