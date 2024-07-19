//
//  PetWatchSwiftApp.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import SwiftUI
import SwiftData

@main
struct PetWatchSwiftApp: App {
    @StateObject var dataModel = DataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: PetBreed.self)
    }
}
