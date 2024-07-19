//
//  Preview+ModelContainer.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([PetBreed.self, Pet.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            PetBreed.insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
