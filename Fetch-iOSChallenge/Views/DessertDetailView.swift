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
        ZStack {
            VStack {
                if vm.dessertImageIsLoading {
                    ProgressView() //when fetching image from server a progress view is shown to show the user there is something to be displayed
                } else {
                    DessertImage
                }
                BottomCardView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            Task {
                try await vm.fetchDessertDetails(dessert: dessertID)
            }
            Task {
                try await vm.fetchImage(picture: dessertImageURL)
            }
        }
    }
    
    private var DessertImage: some View {
        vm.dessertImage?
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .frame(width: 300, height: 300)
    }
    
    private var InstructionsView: some View {
        ForEach(vm.dessertDetails, id: \.dessertName) { detail in
            VStack(alignment: .leading, spacing: 10) {
                Text("Instructions:")
                Text(detail.dessertInstructions)
            }
            .padding([.leading, .trailing])
        }
        
    }
    
    private var IngredientStackView: some View {
        VStack {
            ForEach(vm.ingredientsAndMeasurements.sorted(by: >), id: \.key) { ingredient, measurement in
                HStack {
                    Text("\(ingredient):")
                    Spacer()
                    Text(measurement)
                }
                .padding([.leading, .trailing])
                .padding(.bottom, 1)
            }
        }
    }
    
    private var BottomCardView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.background)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                VStack {
                    Picker("Selection", selection: $vm.detailSelection) {
                        Text("Ingredients")
                            .tag(DetailSelection.ingredients)
                        Text("Instructions")
                            .tag(DetailSelection.instructions)
                    }
                    .pickerStyle(.segmented)
                    ScrollView {
                        switch vm.detailSelection {
                        case .ingredients:
                            IngredientStackView
                        case .instructions:
                            InstructionsView
                        }
                    }
                }
            }
    }
}

#Preview {
    DessertDetailView(dessertID: "52928", dessertImageURL: "https://www.themealdb.com/images/media/meals/ryppsv1511815505.jpg")
}
