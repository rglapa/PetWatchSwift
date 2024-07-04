//
//  Item.swift
//  PetWatchSwift
//
//  Created by Ruben Glapa on 7/4/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
