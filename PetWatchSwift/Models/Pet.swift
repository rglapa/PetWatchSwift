//
//  Pet.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import Foundation
import SwiftData
import PhotosUI

@Model
final class Pet {
    var name: String
    var diet: Diet
    var breed: PetBreed?
    var petPhotos: [Data?] = []
    var petImage: String = ""
    
    
    init() {
        name = ""
        diet = .carnivorous
        petImage = ""
    }
    
    init(name: String,diet: Diet, petPhotos: [Data?], petImage: String) {
        self.name = name
        self.diet = diet
        self.petPhotos = petPhotos
        self.petImage = petImage
    }
}

extension Pet {
    enum Diet: String, CaseIterable, Codable {
        case omnivorous = "Omnivorous"
        case carnivorous = "Carnivorous"
        case herbivorous = "Herbivorous"
    }
}


