//
//  PetBreedListView.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/22/24.
//

import SwiftUI
import SwiftData

struct PetBreedListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PetBreed.name) private var petBreeds: [PetBreed]
    @State private var isReloadPresented = false
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedPetBreedName) {
            ListBreeds(petBreeds: petBreeds)
        }
        .alert("Reload sample data?", isPresented: $isReloadPresented) {
            Button("Yes, reload sample data", role: .destructive) {
                reloadSampleData()
            }
        } message: {
            Text("Reloading the sample data deltes all changes to the current data")
        }
        .task {
            if petBreeds.isEmpty {
                PetBreed.insertSampleData(modelContext: modelContext)
            }
        }
    }
    
    @MainActor
    private func reloadSampleData() {
        navigationContext.selectedPet = nil
        navigationContext.selectedPetBreedName = nil
        PetBreed.reloadSampleData(modelContext: modelContext)
    }
}

struct ListBreeds: View {
    var petBreeds: [PetBreed]
    
    var body: some View {
        ForEach(petBreeds) {breed in
            NavigationLink(breed.name, value: breed.name)
        }
    }
}

#Preview("PetListBreedView") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            PetBreedListView()
        }
        .environment(NavigationContext())
    }
}
