//
//  PetBreed.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import Foundation
import SwiftData

@Model
final class PetBreed {
    @Attribute(.unique) var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Pet.breed)
    var pets = [Pet]()
    
    init(name: String) {
        self.name = name
    }
}
