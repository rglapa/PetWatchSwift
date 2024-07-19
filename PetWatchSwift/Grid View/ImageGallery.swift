//
//  ImageGallery.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/11/24.
//

import SwiftUI

struct ImageGallery: View {
    @State var dataModel = DataModel()
    
    var body: some View {
        NavigationStack {
            GridView()
        }
        .environmentObject(dataModel)
    }
}
