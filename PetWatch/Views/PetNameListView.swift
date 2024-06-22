//
//  PetBreedListView.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/20/24.
//

import SwiftUI
import SwiftData

struct PetNameListView: View {
    
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PetBreed.name) private var petBreeds: [PetBreed]
    @State private var isReloadPresented = false
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedPetBreedName) {
            ListBreeds(petBreeds: petBreeds)
        }
    }
}

struct ListBreeds: View {
    var petBreeds: [PetBreed]
    
    var body: some View {
        ForEach(petBreeds) {petBreed in
            NavigationLink(petBreed.name, value: petBreed.name)
        }
    }
}
