//
//  SampleData+Pet.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/19/24.
//

import Foundation
import SwiftData

extension Pet {
    static let artemis = Pet(name: "Artemis", petType: .dog, breed: .poodle, petPhotos: [])
    static let athena = Pet(name: "Athena", petType: .dog,breed: .poodle, petPhotos: [])
    static let hugo = Pet(name: "Hugo", petType: .dog, breed: .poodle, petPhotos: [])
    static let bradley = Pet(name: "Bradley", petType: .dog, breed: .husky, petPhotos: [])
    
    static func insertSampleData(modelContext: ModelContext) {
        modelContext.insert(artemis)
        modelContext.insert(athena)
        modelContext.insert(hugo)
        modelContext.insert(bradley)
    }
}
