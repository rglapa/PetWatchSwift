//
//  PetEditor.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct PetEditor: View {
    let pet: Pet?
    
    private var editorTitle: String {
        pet == nil ? "Add Pet" : "Edit Pet"
    }
    
    @State private var name = ""
    @State private var selectedType = Pet.Diet.carnivorous
    @State private var selectedBreed: PetBreed?
    @State private var selectedPhotoData: [Data?] = []
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \PetBreed.name) private var breeds: [PetBreed]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Breed", selection: $selectedBreed) {
                    Text("Select a Breed").tag(nil as PetBreed?)
                    ForEach(breeds) { breed in
                        Text(breed.name).tag(breed as PetBreed?)
                    }
                }
                
                Picker("Type", selection: $selectedType) {
                    ForEach(Pet.Diet.allCases, id: \.self) {type in
                        Text(type.rawValue).tag(type)
                    }
                    
                }
                PhotosPicker(selection: $selectedPhotos, label:
                                {Label("Photos",systemImage: "photo")})
                .onChange(of: selectedPhotos) {
                    selectedPhotoData = []
                    for item in selectedPhotos {
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let imageData):
                                if let imageData {
                                    selectedPhotoData.append(imageData)
                                } else {
                                    print("No supported content found")
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                }
                if !selectedPhotoData.isEmpty {
                    ForEach(selectedPhotoData, id: \.self) {petPhoto in
                        Image(uiImage: UIImage(data: petPhoto ?? Data()) ?? UIImage())
                            .resizable()
                            .scaledToFit()
                    }
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
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let pet {
                    name = pet.name
                    selectedType = pet.diet
                    selectedBreed = pet.breed
                    selectedPhotoData = pet.petPhotos
                }
            }
        }
    }
    private func save() {
        if let pet {
            pet.name = name
            pet.diet = selectedType
            pet.breed = selectedBreed
            pet.petPhotos = selectedPhotoData
        } else {
            let newPet = Pet(name:name,diet:selectedType,petPhotos: [], petImage: "")
            newPet.breed = selectedBreed
            modelContext.insert(newPet)
            
        }
    }
}

#Preview("Add Pet") {
    ModelContainerPreview(ModelContainer.sample) {
        PetEditor(pet: nil)
    }
}

#Preview("Edit Pet") {
    ModelContainerPreview(ModelContainer.sample) {
        PetEditor(pet: .artemis)
    }
}
