//
//  NavigationContext.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import SwiftUI

@Observable
class NavigationContext {
    var selectedPetBreedName: String?
    var selectedPet: Pet?
    var columnVisibility: NavigationSplitViewVisibility
    
    var sidebarTitle = "Breeds"
    
    var contentListTitle: String {
        if let selectedPetBreedName {
            selectedPetBreedName
        } else {
            ""
        }
    }
    init(selectedPetBreedName: String? = nil, selectedPet: Pet? = nil, columnVisibility: NavigationSplitViewVisibility = .automatic, sidebarTitle: String = "Breeds") {
        self.selectedPetBreedName = selectedPetBreedName
        self.selectedPet = selectedPet
        self.columnVisibility = columnVisibility
        self.sidebarTitle = sidebarTitle
    }
}
