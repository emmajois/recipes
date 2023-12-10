//
//  Recipe.swift
//  recipes
//
//  Created by Emma Swalberg on 11/21/23.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var author: String
    var date: Date
    var prepTime: Int
    var cookTime: Int
    var servings: Int
    var expertise: Int
    var calories: Int
    var isFavorite: Bool
    @Relationship(deleteRule: .cascade)
    var ingredients: [RecipeIngredient]?
    @Relationship(deleteRule: .cascade)
    var instructions: [RecipeInstruction]?
    var categories: [RecipeCategory]?
    
    init(title: String, author: String, date: Date, prepTime: Int, cookTime: Int, servings: Int, expertise: Int, calories: Int, isFavorite: Bool) {
        self.title = title
        self.author = author
        self.date = date
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.servings = servings
        self.expertise = expertise
        self.calories = calories
        self.isFavorite = isFavorite
    }
}

@Model
final class RecipeIngredient {
    var ingredientName: String
    var measurement: String
    var note: String?
    var recipe: Recipe?
    
    init(ingredientName: String, measurement: String, note:  String?, recipe: Recipe?) {
        self.ingredientName = ingredientName
        self.measurement = measurement
        self.note = note
        self.recipe = recipe
    }
}

@Model
final class RecipeInstruction {
    var instructionDescription: String
    var order: Int
    var recipe: Recipe?

    init(instructionDescription: String, order: Int, recipe: Recipe?) {
        self.instructionDescription = instructionDescription
        self.order = order
        self.recipe = recipe
    }
}

@Model
final class RecipeCategory {
    var categoryName: String
    var recipe: Recipe?
    
    init(categoryName: String) {
        self.categoryName = categoryName
    }
}
