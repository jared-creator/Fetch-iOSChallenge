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
    
    var body: some View {
        List {
            ForEach(vm.dessertDetails, id: \.dessertName) { detail in
                Text(detail.strIngredient1)
            }
        }
        .onAppear {
            Task {
                do {
                    try await vm.fetchDessertDetails(dessert: dessertID)
                } catch {
                    
                }
            }
        }
    }
}

#Preview {
    DessertDetailView(dessertID: "52928")
}
