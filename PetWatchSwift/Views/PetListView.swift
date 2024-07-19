//
//  PetListView.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/6/24.
//

import SwiftUI
import SwiftData

struct PetListView: View {
    let petBreedName: String?
    
    var body: some View {
        if let petBreedName {
            PetList(petBreedName: petBreedName)
        } else {
            ContentUnavailableView("Select a category", systemImage: "sidebar.left")
        }
    }
}

private struct PetList: View {
    let petBreedName: String
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Pet.name) private var pets: [Pet]
    @State private var isEditorPresentedPet = false
    
    init(petBreedName: String) {
        self.petBreedName = petBreedName
        let predicate = #Predicate<Pet> { pet in
            pet.breed?.name == petBreedName
        }
        _pets = Query(filter: predicate, sort: \Pet.name)
    }
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedPet) {
            ForEach(pets) {pet in
                NavigationLink(pet.name, value: pet)
            }
            .onDelete(perform: removePets)
        }
        .sheet(isPresented: $isEditorPresentedPet) {
            PetEditor(pet: nil)
        }
        .overlay {
            if pets.isEmpty {
                ContentUnavailableView {
                    Label("No pets in this category", systemImage: "pawprint")
                } description: {
                    AddPetButton(isActive: $isEditorPresentedPet)
                }
            }
        }
        .toolbar {
            if !pets.isEmpty {
                ToolbarItem(placement: .primaryAction) {
                    AddPetButton(isActive: $isEditorPresentedPet)
                }
            }
        }
        .task {
            print(pets.count)
        }
    }
    
    private func removePets(at indexSet: IndexSet) {
        for index in indexSet {
            let animalToDelete = pets[index]
            if navigationContext.selectedPet?.persistentModelID == animalToDelete.persistentModelID {
                navigationContext.selectedPet = nil
            }
            modelContext.delete(animalToDelete)
        }
    }
}

private struct AddPetButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add an animal", systemImage: "plus")
        }
    }
}

#Preview("PetListView") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            PetListView(petBreedName: PetBreed.husky.name)
                .environment(NavigationContext())
        }
    }
}
