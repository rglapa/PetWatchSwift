//
//  PetListView.swift
//  PetWatch
//
//  Created by Ruben Glapa on 6/19/24.
//

import SwiftUI
import SwiftData

struct PetListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Example Text")
    }
}

#Preview {
    PetListView()
}
