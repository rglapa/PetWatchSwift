//
//  PetBreedEditor.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/6/24.
//

import SwiftUI
import SwiftData

struct PetBreedEditor: View {
    let petBreed: PetBreed?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    
    @State var name = ""
    @State var selectedBreed: PetBreed?
    
    private var editorTitle: String {
        petBreed == nil ? "Add Breed" : "Edit Breed"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Breed Name", text: $name)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let petBreed {
                    name = petBreed.name

                }
            }
        }
    }
    private func save() {
        if let petBreed {
            petBreed.name = name
        } else {
            let newBreed = PetBreed(name: name)
            selectedBreed = newBreed
            modelContext.insert(newBreed)
        }
    }
}

#Preview {
    PetBreedEditor(petBreed: nil)
}
