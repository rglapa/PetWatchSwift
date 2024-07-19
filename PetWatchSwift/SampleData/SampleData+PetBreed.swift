//
//  SampleData+PetBreed.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import Foundation
import SwiftData

extension PetBreed {
    static let husky = PetBreed(name: "Husky")
    static let poodle = PetBreed(name: "Poodle")
    static let germanShepard = PetBreed(name:"German Shepard")
    static let labradorRetriever = PetBreed(name:"Labrador Retriever")
    static let alaskanMalamute = PetBreed(name:"Alaskan Malamute")
    static let dachshund = PetBreed(name:"Dachshund")
    static let beagle = PetBreed(name:"Beagle")
    static let chihuahua = PetBreed(name:"Chihuahua")
    static let borderCollie = PetBreed(name: "Border Collie")
    static let yorkshireTerrier = PetBreed(name: "Yorkshire Terrier")
    static let doberman = PetBreed(name: "Doberman")
    static let bassetHound = PetBreed(name: "Basset Hound")
    static let corgi = PetBreed(name: "Corgi")
    
    static func insertSampleData(modelContext: ModelContext) {
        modelContext.insert(husky)
        modelContext.insert(poodle)
        modelContext.insert(germanShepard)
        modelContext.insert(labradorRetriever)
        modelContext.insert(alaskanMalamute)
        modelContext.insert(dachshund)
        modelContext.insert(beagle)
        modelContext.insert(chihuahua)
        modelContext.insert(borderCollie)
        modelContext.insert(yorkshireTerrier)
        modelContext.insert(doberman)
        modelContext.insert(bassetHound)
        modelContext.insert(corgi)
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
