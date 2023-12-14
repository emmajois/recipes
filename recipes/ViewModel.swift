//
//  ViewModel.swift
//  recipes
//
//  Created by Emma Swalberg on 12/11/23.
//

import Foundation
import SwiftData

@Observable
class ViewModel {
    //MARK: - Properties
    private var modelContext: ModelContext
    
    //MARK: - Initialization
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }
    
    //MARK: - Model Access
    private(set) var recipes: [Recipe] = []
    private(set) var filteredRecipes: [Recipe] = []
    private(set) var categories: [RecipeCategory] = []
    private(set) var favoriteRecipes: [Recipe] = []
    
    //MARK: - User intents
    func addRecipe(_ recipe: Recipe) {
        modelContext.insert(recipe)
        
        fetchData()
    }
    
    func addCategory(_ category: RecipeCategory) {
        modelContext.insert(category)
        
        fetchData()
    }
    
    func saveData() {
        try? modelContext.save()
        
        fetchData()
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        modelContext.delete(recipe)
        
        fetchData()
    }
    
    func deleteCategory(_ category: RecipeCategory) {
        modelContext.delete(category)
        
        fetchData()
    }
    
    func replaceAllRecipes(
        _ recipes: [Recipe],
        _ baseCategories: [RecipeCategory],
        _ associations: [(String, String)]
    ) throws {
        do {
            try modelContext.delete(model: Recipe.self)
            try modelContext.delete(model: RecipeCategory.self)
        } catch {
            throw error
        }
        
        var recipeTable: [String : Recipe] = [:]
        var categoryTable: [String : RecipeCategory] = [:]
        
        recipes.forEach { recipe in
            recipeTable[recipe.title] = recipe
            modelContext.insert(recipe)
        }
        
        baseCategories.forEach { category in
            categoryTable[category.categoryName] = category
            modelContext.insert(category)
        }
        
        associations.forEach { (recipe, category) in
            if let recipeItem = recipeTable[recipe], let categoryItem = categoryTable[category] {
                recipeItem.categories.append(categoryItem)
            }
        }
        
        fetchData()
    }
    
    //MARK: - Private Helpers
    private func fetchData() {
        fetchRecipes()
        fetchFilteredRecipes()
        fetchFavoriteRecipes()
        fetchCategories()
    }
    
    private func fetchFilteredRecipes() {
        do {
            let descriptor = FetchDescriptor<Recipe>(
                predicate: #Predicate<Recipe> { $0.title.contains("l")},
                sortBy: [SortDescriptor(\.title)]
            )
            
            filteredRecipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load filtered recipes")
        }
    }
    private func fetchFavoriteRecipes() {
        do {
            let descriptor = FetchDescriptor<Recipe>(
                predicate: #Predicate<Recipe> {$0.isFavorite},
                sortBy: [SortDescriptor(\.title)]
            )
            
            favoriteRecipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load favorite recipes")
        }
    }
    
    private func fetchRecipes() {
        do {
            let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
            
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load recipes")
        }
    }
    
    private func fetchCategories() {
        do {
            let descriptor = FetchDescriptor<RecipeCategory>(sortBy: [SortDescriptor(\.categoryName)])
            
            categories = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load categories")
        }
    }
}
