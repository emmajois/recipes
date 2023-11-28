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
    var title: String
    var ingredients: String
    var instructions: String
        
    init(title: String, ingredients: String, instructions: String) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
    }
}
