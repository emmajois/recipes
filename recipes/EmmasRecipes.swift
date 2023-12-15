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
    ),
    Recipe(title: "Pumpkin Bars",
           author: "Grandma Louise",
           date: Date.now,
           prepTime: 30,
           cookTime: 30,
           servings: 8,
           expertise: 2,
           calories: 300,
           isFavorite: true,
           ingredients: [
                RecipeIngredient(ingredientName: "Canned Pumpkin", measurement: "2 Cups", note: "Libby's Brand"),
                RecipeIngredient(ingredientName: "Cooking Oil", measurement: "1/4 Cup", note: nil),
                RecipeIngredient(ingredientName: "Eggs", measurement: "4", note: nil),
                RecipeIngredient(ingredientName: "Flour", measurement: "2 Cups", note: nil),
                RecipeIngredient(ingredientName: "Cinnamon", measurement: "2 teaspoons", note: nil),
                RecipeIngredient(ingredientName: "Salt", measurement: "1 teaspoon", note: nil),
                RecipeIngredient(ingredientName: "Baking Powder", measurement: "2 teaspoons", note: nil),
                RecipeIngredient(ingredientName: "Baking Soda", measurement: "1 teaspoon", note: nil),
                RecipeIngredient(ingredientName: "Sugar", measurement: "1 & 1/2 Cups", note: nil),
                RecipeIngredient(ingredientName: "Chocolate Chips", measurement: "Half a Bag", note: nil),
                RecipeIngredient(ingredientName: "Cinnamon Sugar", measurement: "1/2 Cup", note: "enough to cover")
           ],
           instructions: [
                RecipeInstruction(instructionDescription: "Preheat oven to 350 Degrees.", order: 1),
                RecipeInstruction(instructionDescription: "Combine the wet ingredients in your mixer.", order: 2),
                RecipeInstruction(instructionDescription: "Combine all the dry ingredients in a seperate bowl and slowly add to the wet mix.", order: 3),
                RecipeInstruction(instructionDescription: "Once just combined, pour into a greased 15x10x1 inch pan (cookie sheet with an edge).", order: 4),
                RecipeInstruction(instructionDescription: "Sprinkle Liberally with the cinnamon sugar. (Put so much on it so it can't soak in.", order: 5),
                RecipeInstruction(instructionDescription: "Bake for 25-30 minutes or until a toothpick comes out clean.", order: 6)
           ],
           categories: []
    ),
    Recipe(title: "Pumpkin Waffles",
           author: "Emma Joi",
           date: Date.now,
           prepTime: 10,
           cookTime: 30,
           servings: 8,
           expertise: 2,
           calories: 350,
           isFavorite: false,
           ingredients: [
                RecipeIngredient(ingredientName: "Flour", measurement: "2 Cups", note: nil),
                RecipeIngredient(ingredientName: "Brown Sugar", measurement: "1/2 Cup", note: "packed"),
                RecipeIngredient(ingredientName: "Baking Powder", measurement: "2 & 1/4 teaspoons", note: nil),
                RecipeIngredient(ingredientName: "Cinnamon", measurement: "1 & 1/2 teaspoons", note: nil),
                RecipeIngredient(ingredientName: "Salt", measurement: "1 teaspoon", note: nil),
                RecipeIngredient(ingredientName: "Eggs", measurement: "2", note: nil),
                RecipeIngredient(ingredientName: "Milk", measurement: "1 & 1/2 Cups", note: nil),
                RecipeIngredient(ingredientName: "Canola Oil", measurement: "3 Tablespoons", note: nil),
                RecipeIngredient(ingredientName: "Canned Pumpkin", measurement: "1 Cup", note: nil)
           ],
           instructions: [
                RecipeInstruction(instructionDescription: "Mix all of the dry ingredients together.", order: 1),
                RecipeInstruction(instructionDescription: "In a seperate bowl combine all the wet ingredients.", order: 2),
                RecipeInstruction(instructionDescription: "Pour the dry ingredients in the bowl with the wet ingredients and mix together.", order: 3),
                RecipeInstruction(instructionDescription: "Spray the inside of the waffle iron on the top and bottom and cook the waffles.", order: 4)
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
    ("Potato Leek Soup", "Appetizer"),
    ("Pumpkin Bars", "Dessert"),
    ("Pumpkin Waffles", "Breakfast"),
    ("Pumpkin Waffles", "Dessert")
]

