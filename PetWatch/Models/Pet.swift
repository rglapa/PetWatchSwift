//
//  Pet.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/15/24.
//

import Foundation
import SwiftData
import PhotosUI

@Model
final class Pet {
    
    @Attribute(.unique) var name: String
    var petType: PetType
    var petPhotos: [Data?] = []
    var petBreed: PetBreed
    
    init () {
        name = ""
        petType = .dog
        petBreed = .poodle
    }
    init(name: String, petType: PetType,breed: PetBreed, petPhotos: [Data?]) {
        self.name = name
        self.petType = petType
        self.petPhotos = petPhotos
        self.petBreed = breed
    }
}

extension Pet {
    enum PetType: String, CaseIterable, Codable {
        case dog = "Dog"
        case cat = "Cat"
        case bird = "Bird"
        case turtle = "Turtle"
    }
}
