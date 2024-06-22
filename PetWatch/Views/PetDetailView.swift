//
//  PetDetailView.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/19/24.
//

import SwiftUI
import SwiftData

struct PetDetailView: View {
    var pet: Pet?
    @State private var isEditing = false
    @State private var isDeleting = false
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationContext.self) private var navigationContext
    
    
    var body: some View {
        if let pet {
            PetDetailContentView(pet: pet)
                .navigationTitle("\(pet.name)")
                .toolbar {
                    Button { isEditing = true } label: {
                        Label("Edit \(pet.name)", systemImage: "pencil")
                            .help("Edit the pet")
                    }
                    Button { isDeleting = true } label: {
                        Label("Delete \(pet.name)", systemImage: "trash")
                            .help("Delete the pet")
                    }
                }
                .sheet(isPresented: $isEditing) {
                    PetEditorView(pet: pet)
                }
                .alert("Delete \(pet.name)?", isPresented: $isDeleting) {
                    Button("Yes, delete \(pet.name)", role: .destructive) {
                        delete(pet)
                    }
                }
        } else {
            ContentUnavailableView("Select a pet", systemImage: "pawprint")
        }
    }
    
    private func delete(_ pet: Pet) {
        navigationContext.selectedPet = nil
        modelContext.delete(pet)
    }
}

private struct PetDetailContentView: View {
    let pet: Pet
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Name")
                    Spacer()
                    Text("\(pet.name)")
                }
            }
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        PetDetailView(pet:.artemis).environment(NavigationContext())
    }
}
