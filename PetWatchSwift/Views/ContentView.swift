//
//  ContentView.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/5/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var navigationContext = NavigationContext()
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        TabView {
            Tab("List", systemImage: "clipboard") {
                ColumnContentView()
                    .environment(navigationContext)
            }
            Tab("Maps", systemImage: "map") {
                MapView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
