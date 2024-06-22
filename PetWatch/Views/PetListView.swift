//
//  PetListView.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/19/24.
//

import SwiftUI
import SwiftData

struct PetListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(NavigationContext.self) private var navigationContext
    @Query(sort: \Pet.name) private var pets: [Pet]
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            PetNameListView()
            .navigationTitle(navigationContext.sidebarTitle)
        } content: {
            
        } detail: {
            NavigationStack {
                PetDetailView(pet: navigationContext.selectedPet)
            }
        }
    }
}

#Preview {
    PetListView().modelContainer(try! ModelContainer.sample())
}
