//
//  Recipe.swift
//  recipes
//
//  Created by Emma Swalberg on 11/21/23.
//

/// The video helped with a lot of the model creation for one to many relationships https://www.youtube.com/watch?v=dAMFgq4tDPM

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
    var categories: [RecipeCategory]
    
    init(title: String, author: String, date: Date, prepTime: Int, cookTime: Int, servings: Int, expertise: Int, calories: Int, isFavorite: Bool, categories: [RecipeCategory]) {
        self.title = title
        self.author = author
        self.date = date
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.servings = servings
        self.expertise = expertise
        self.calories = calories
        self.isFavorite = isFavorite
        self.categories = categories
    }
}

@Model
final class RecipeIngredient {
    var ingredientName: String
    var measurement: String
    var note: String?
    
    init(ingredientName: String, measurement: String, note: String?) {
        self.ingredientName = ingredientName
        self.measurement = measurement
        self.note = note
    }
}

@Model
final class RecipeInstruction {
    var instructionDescription: String
    var order: Int

    init(instructionDescription: String, order: Int) {
        self.instructionDescription = instructionDescription
        self.order = order
    }
}

@Model
final class RecipeCategory {
    var categoryName: String
    @Relationship(inverse: \Recipe.categories)
    var recipes: [Recipe] = []
    
    init(categoryName: String, recipes: [Recipe] = []) {
        self.categoryName = categoryName
        self.recipes = recipes
    }
}
