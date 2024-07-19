//
//  PetBreedListView.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import SwiftUI
import SwiftData

struct PetBreedListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PetBreed.name) private var petBreeds: [PetBreed]
    @State private var isReloadPresented = false
    @State private var isEditorPresented = false
    @State private var isPetEditorPresented = false
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedPetBreedName) {
            ListBreeds(petBreeds: petBreeds)
        }
        
        /*.overlay {
            if petBreeds.isEmpty {
                ContentUnavailableView {
                    Label("No Breeds Yet", systemImage: "pawprint")
                } description: {
                    AddBreedButton(isActive: $isEditorPresented)
                }
            }
        }*/
        .sheet(isPresented: $isEditorPresented) {
            PetBreedEditor(petBreed: nil)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isPetEditorPresented) {
            PetEditor(pet: nil)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddBreedButton(isActive: $isEditorPresented)
            }
            ToolbarItem(placement: .primaryAction) {
                AddPetButton(isActive: $isPetEditorPresented)
            }
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

private struct AddBreedButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add a Breed", systemImage: "plus")
        }
    }
}

private struct AddPetButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        HStack {
            Button {
                isActive = true
            }label: {
                HStack {
                    Text("Add Pet")
                    Label("Add a Pet", systemImage: "plus").foregroundStyle(.green)
                }
            }
        }
        Spacer()
    }
}

private struct ListBreeds: View {
    var petBreeds: [PetBreed]
    
    var body: some View {
        ForEach(petBreeds) {petBreed in
            NavigationLink(petBreed.name, value: petBreed.name)
        }
        
        .task {
            print("\(petBreeds.count)")
        }
    }
}

#Preview("PetBreedsListView") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            PetBreedListView()
        }
        .environment(NavigationContext())
    }
}

#Preview("No Breeds Listed") {
    PetBreedListView()
        .environment(NavigationContext())
}
#Preview("ListBreeds") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            List {
                ListBreeds(petBreeds: [.husky,.poodle])
            }
        }
    }
}

#Preview("ListBreeds") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            List {
                ListBreeds(petBreeds: [.husky,.poodle])
            }
        }
    }
}
