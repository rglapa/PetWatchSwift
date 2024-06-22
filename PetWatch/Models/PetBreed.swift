//
//  PetBreed.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/19/24.
//

import Foundation
import SwiftData

@Model
final class PetBreed {
    @Attribute(.unique) var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Pet.petBreed)
    var pets = [Pet]()
    
    init(name: String) {
        self.name = name
    }
}
