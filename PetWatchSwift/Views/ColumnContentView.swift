//
//  ColumnContentView.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import SwiftUI
import SwiftData

struct ColumnContentView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            PetBreedListView()
                .navigationTitle(navigationContext.sidebarTitle)
        }content: {
            PetListView(petBreedName: navigationContext.selectedPetBreedName)
                .navigationTitle(navigationContext.contentListTitle)
        } detail: {
            NavigationStack {
                PetDetailView(pet: navigationContext.selectedPet)
            }
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ColumnContentView().environment(NavigationContext())
    }
}
