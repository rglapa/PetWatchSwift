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
    
    
    init() {
        name = ""
        diet = .carnivorous
    }
    
    init(name: String,diet: Diet, petPhotos: [Data?]) {
        self.name = name
        self.diet = diet
        self.petPhotos = petPhotos
    }
}

extension Pet {
    enum Diet: String, CaseIterable, Codable {
        case omnivorous = "Omnivorous"
        case carnivorous = "Carnivorous"
        case herbivorous = "Herbivorous"
    }
}
