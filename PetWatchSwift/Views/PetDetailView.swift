//
//  PetDetailView.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/6/24.
//

import SwiftUI
import SwiftData
import PhotosUI

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
                        Label("Delete \(pet.name)",systemImage: "trash")
                            .help("Delete the pet")
                    }
                }
                .sheet(isPresented: $isEditing) {
                    PetEditor(pet: pet)
                }
                .alert("Delete \(pet.name)", isPresented: $isDeleting) {
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
    let rows = [GridItem(.fixed(100)), GridItem(.fixed(100)),GridItem(.fixed(100))]
    @State private var photoSelection: [PhotosPickerItem] = []
    @State private var photoData: [Data] = []
    //@State private var selection: Data
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Breed")
                    Spacer()
                    Text("\(pet.breed?.name ?? "")")
                }
                HStack {
                    Text("Diet")
                    Spacer()
                    Text("\(pet.diet.rawValue)")
                }
                VStack {
                    if pet.petPhotos.isEmpty {
                        PhotosPicker(selection: $photoSelection, label: {
                            Label("Photos", systemImage: "photo")
                        })
                        .onChange(of: photoSelection) {
                            pet.petPhotos = []
                            for item in photoSelection {
                                item.loadTransferable(type: Data.self) { data in
                                    switch data {
                                    case .success(let imageData):
                                        pet.petPhotos.append(imageData)
                                    case .failure(let error):
                                        print("\(error.localizedDescription)")
                                    }
                                }
                            }
                        }
                    }
                    LazyVGrid(columns: rows) {
                        
                        ForEach(pet.petPhotos, id: \.self) { photo in
                                Image(uiImage: UIImage(data: photo ?? Data()) ?? UIImage())
                                    .resizable()
                                    .symbolRenderingMode(.multicolor)
                                    .frame(width: 30, height: 30)
                                    
                        }
                    }
                    if !pet.petPhotos.isEmpty {
                        Button("Remove Images", action: {
                            pet.petPhotos = []
                        })
                    }
                    
                }
                
            }
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        PetDetailView(pet: .artemis)
            .environment(NavigationContext())
    }
}
