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
    
    var name: String
    var petType: PetType
    var petPhotos: [Data?] = []
    
    init () {
        name = ""
        petType = .dog
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
