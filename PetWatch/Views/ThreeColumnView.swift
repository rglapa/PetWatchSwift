//
//  ThreeColumnView.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/22/24.
//

import SwiftUI
import SwiftData

struct ThreeColumnView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationContext.self) private var navigationContext
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            PetBreedListView()
        } detail: {
            NavigationStack {
                PetDetailView(pet: navigationContext.selectedPet)
            }
        }
    }
}
