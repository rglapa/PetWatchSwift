//
//  SampleData+PetBreed.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/19/24.
//

import Foundation
import SwiftData

extension PetBreed {
    
    static let poodle = PetBreed(name: "Poodle")
    static let labrador = PetBreed(name: "Labrador")
    static let husky = PetBreed(name: "Husky")
    
    static func insertSampleData(modelContext: ModelContext) {
        modelContext.insert(poodle)
        modelContext.insert(labrador)
        modelContext.insert(husky)
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: PetBreed.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
