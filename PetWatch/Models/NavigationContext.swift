//
//  NavigationContext.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/15/24.
//

import SwiftUI

@Observable
class NavigationContext {
    var selectedPetBreedName: String?
    var selectedPet: Pet?
    var columnVisibility: NavigationSplitViewVisibility
    
    var sidebarTitle = "Pets"
    
    var contentListTitle: String {
        if let selectedPetBreedName {
            selectedPetBreedName
        } else {
            ""
        }
    }
    
    init(selectedPetBreedName: String? = nil,selectedPet: Pet? = nil, columnVisibility: NavigationSplitViewVisibility = .automatic) {
        self.selectedPetBreedName = selectedPetBreedName
        self.selectedPet = selectedPet
        self.columnVisibility = columnVisibility
    }
}
