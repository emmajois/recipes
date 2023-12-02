//
//  Item.swift
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
    var expertise: expertiseEnum
    var calories: Int
    var isFavorite: Bool
    var ingredients: [RecipeIngredient]
    var instructions: [RecipeInstruction]
    var categories: [RecipeCategory]
    
    init(title: String, author: String, date: Date, prepTime: Int, cookTime: Int, servings: Int, expertise: expertiseEnum, calories: Int, isFavorite: Bool, ingredients: [RecipeIngredient], instructions: [RecipeInstruction], categories: [RecipeCategory]) {
        self.title = title
        self.author = author
        self.date = date
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.servings = servings
        self.expertise = expertise
        self.calories = calories
        self.isFavorite = isFavorite
        self.ingredients = ingredients
        self.instructions = instructions
        self.categories = categories
    }
}

@Model
final class RecipeIngredient {
    var ingredientName: String
    var measurement: String
    var note: String
    
    init(ingredientName: String, measurement: String, note: String) {
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
    
    init(categoryName: String) {
        self.categoryName = categoryName
    }
}

enum expertiseEnum: String, CaseIterable {
    case beginner
    case novice
    case intermediate
    case master
}
