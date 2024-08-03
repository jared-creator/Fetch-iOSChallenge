//
//  ContentView.swift
//  Fetch-iOSChallenge
//
//  Created by JaredMurray on 7/31/24.
//

import SwiftUI

struct DessertListView: View {
    @State private var vm = DessertListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dessertList, id: \.dessertID) { dessert in
                    NavigationLink(destination: DessertDetailView(dessertID: dessert.dessertID, dessertImageURL: dessert.dessertPictureURL).navigationTitle(dessert.dessertName)) {
                        Text(dessert.dessertName)
                        //Text(dessert.dessertID) for development issues
                    }
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Desserts")
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .onAppear {
                Task {
                    do {
                        try await vm.fetchDessertList()
                    } catch {
                        print(error.localizedDescription)
                        //handle errors
                    }
                }
            }
        }
    }
}

#Preview {
    DessertListView()
}
