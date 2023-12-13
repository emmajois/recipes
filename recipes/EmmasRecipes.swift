//
//  EmmasRecipes.swift
//  recipes
//
//  Created by Emma Swalberg on 12/11/23.
//

import Foundation

let emmaSampleRecipes = [
    Recipe(
        title: "Black Bean Salsa",
        author: "Emma Joi",
        date: Date.now,
        prepTime: 20,
        cookTime: 0,
        servings: 10,
        expertise: 2,
        calories: 100,
        isFavorite: true,
        ingredients: [
            RecipeIngredient(ingredientName: "Fresh Lime Juice", measurement: "1/3 Cup", note: nil),
            RecipeIngredient(ingredientName: "Olive Oil", measurement: "1/2 Cup", note: nil),
            RecipeIngredient(ingredientName: "Garlic", measurement: "1 Clove", note: "minced"),
            RecipeIngredient(ingredientName: "Salt", measurement: "1 teaspoon", note: nil),
            RecipeIngredient(ingredientName: "Ground Cayenne Pepper", measurement: "1/8 teaspoon", note: "or more to taste"),
            RecipeIngredient(ingredientName: "Black Beans", measurement: "2 (15 oz) cans", note: "rinsed and drained"),
            RecipeIngredient(ingredientName: "Avocado", measurement: "1", note: "diced"),
            RecipeIngredient(ingredientName: "Tomatoes", measurement: "2", note: "chopped"),
            RecipeIngredient(ingredientName: "Green Onions", measurement: "6", note: "thinly sliced"),
            RecipeIngredient(ingredientName: "Cilantro", measurement: "1/2 Cup", note: "chopped")
        ],
        instructions: [
            RecipeInstruction(instructionDescription: "Combine lime juice, olive oil, garlic, salt, and cayenne pepper in a small bowl. Stir well.", order: 1),
            RecipeInstruction(instructionDescription: "In a large bowl, combine beans, avocado, tomatoes, green onions, and cilantro.", order: 2),
            RecipeInstruction(instructionDescription: "Pour liquid and stir to coat vegetables and beans.", order: 3),
            RecipeInstruction(instructionDescription: "Add more salt and pepper to taste.", order: 4),
            RecipeInstruction(instructionDescription: "Serve with torillia chips", order: 5)
        ],
        categories: []
    ),
    Recipe(
        title: "Potato Leek Soup",
        author: "Emma Joi",
        date: Date.now,
        prepTime: 10,
        cookTime: 45,
        servings: 8,
        expertise: 2,
        calories: 300,
        isFavorite: false,
        ingredients: [
            RecipeIngredient(ingredientName: "Butter", measurement: "1 Cup", note: nil),
            RecipeIngredient(ingredientName: "Leeks", measurement: "2", note: "sliced"),
            RecipeIngredient(ingredientName: "Salt and Pepper", measurement: "to taste", note: nil),
            RecipeIngredient(ingredientName: "Chicken Broth", measurement: "1 Quart", note: nil),
            RecipeIngredient(ingredientName: "Cornstarch", measurement: "1 Tablespoon", note: nil),
            RecipeIngredient(ingredientName: "Potatoes", measurement: "4 Cups", note: "peeled and diced"),
            RecipeIngredient(ingredientName: "Heavy Cream", measurement: "2 Cups", note: nil)
        ],
        instructions: [
            RecipeInstruction(instructionDescription: "In a large pot over medium heat, melt butter. Cook leeks in butter with salt and pepper until tender, stirring frequently (about 10 minutes).", order: 1),
            RecipeInstruction(instructionDescription: "Whisk cornstarch into broth and pour into the pot with the leeks.", order: 2),
            RecipeInstruction(instructionDescription: "Add the potatoes and bring to a boil. Pour in the cream, reduce heat, and allow to simmer for 30 minutes, until potatoes are tender.", order: 3),
            RecipeInstruction(instructionDescription: "Using a pastry cutter, mash some of the potatoes so the soup will be thicker. If it still isn't thick enough for you, add some instant mashed potatoes (about 1/4 cup).", order: 4),
            RecipeInstruction(instructionDescription: "Season with salt and pepper to taste. Top with grated cheese.", order: 5)
        ],
        categories: []
    )
]

let baseCategories = [
    RecipeCategory(categoryName: "Breakfast"),
    RecipeCategory(categoryName: "Lunch"),
    RecipeCategory(categoryName: "Dinner"),
    RecipeCategory(categoryName: "Dessert"),
    RecipeCategory(categoryName: "Appetizer"),
    RecipeCategory(categoryName: "Other")
]

let sampleAssociations = [
    ("Black Bean Salsa", "Lunch"),
    ("Black Bean Salsa", "Dinner"),
    ("Black Bean Salsa", "Appetizer"),
    ("Potato Leek Soup", "Dinner"),
    ("Potato Leek Soup", "Appetizer")
]

