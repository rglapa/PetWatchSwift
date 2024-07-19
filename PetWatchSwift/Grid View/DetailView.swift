//
//  DetailView.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/10/24.
//

import SwiftUI

struct DetailView: View {
    let item: Item
    
    var body: some View {
        AsyncImage(url: item.url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}
