//
//  Item.swift
//  recipes
//
//  Created by Emma Swalberg on 11/21/23.
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
