//
//  PetEditorView.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/19/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct PetEditorView: View {
    let pet: Pet?
    
    private var editorTitle: String {
        pet == nil ? "Add Pet" : "Edit Pet"
    }
    
    @State private var name = ""
    @State private var selectedType = Pet.PetType.dog
    @State private var selectedBreed: PetBreed?
    @State private var selectedPhotoItems: [Data?] = []
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \PetBreed.name) private var breeds: [PetBreed]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name",text: $name)
                
                Picker("Breed", selection: $selectedBreed) {
                    Text("Select a breed").tag(nil   as PetBreed?)
                    ForEach(breeds) { breed in
                        Text(breed.name).tag(breed as PetBreed?)
                    }
                }
                
                PhotosPicker(selection: $selectedPhotos, label: {
                    Label("Photos", systemImage: "photo")
                })
                .onChange(of: selectedPhotos) {
                    selectedPhotoItems = []
                    for item in selectedPhotos {
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let imageData):
                                if let imageData {
                                    selectedPhotoItems.append(imageData)
                                } else {
                                    print("No supported content found")
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
                if !selectedPhotoItems.isEmpty {
                    ForEach(selectedPhotoItems, id: \.self) { petPhoto in
                        Image(uiImage: UIImage(data: petPhoto ?? Data()) ?? UIImage())
                            .resizable()
                            .scaledToFill()
                    }
                    Button(role: .destructive) {
                        withAnimation {
                            pet?.petPhotos = []
                            selectedPhotoItems = []
                            selectedPhotos = []
                        }
                    } label: {
                        Label("Remove Images", systemImage: "xmark")
                            .foregroundStyle(.red)
                    }
                }
            }
            .onAppear {
                if let pet {
                    name = pet.name
                    selectedType = pet.petType
                    selectedPhotoItems = pet.petPhotos
                }
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
                    .disabled($selectedBreed.wrappedValue == nil)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
        
    }
    
    private func save() {
        if let pet {
            pet.name = name
            pet.petType = selectedType
            pet.petPhotos = selectedPhotoItems
        } else {
            let newPet = Pet(name: name, petType: selectedType, breed: .poodle, petPhotos: [])
            modelContext.insert(newPet)
        }
    }
}

#Preview("Add Pet") {
    ModelContainerPreview(ModelContainer.sample) {
        PetEditorView(pet: nil)
    }
}

#Preview("Edit Pet") {
    ModelContainerPreview(ModelContainer.sample) {
        PetEditorView(pet: .artemis)
    }
}
