//
//  MapView.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/7/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let parking = CLLocationCoordinate2D(latitude: 42.354528, longitude: -71.068369)
}

struct MapView: View {
    
    var body: some View {
        Map {
            Annotation("Parking", coordinate: .parking) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, lineWidth: 5)
                    Image(systemName: "car")
                        .padding(5)
                }
            }
            .annotationTitles(.hidden)
        }
        .mapStyle(.standard(elevation: .realistic))
    }
}

#Preview {
    MapView()
}
