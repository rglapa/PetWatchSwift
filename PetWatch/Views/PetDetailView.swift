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
                .sheet(isPresented: $isEditing) {
                    PetEditorView(pet: pet)
                }
        }
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
    PetDetailView().environment(NavigationContext())
}
