//
//  ImageDetailView.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/14/24.
//

import SwiftUI

struct ImageDetailView: View {
    var currentUIImage: Color
    
    var body: some View {
        currentUIImage.navigationTitle(currentUIImage.description)
    }
}
