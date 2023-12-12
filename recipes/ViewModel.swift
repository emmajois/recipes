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
    
    //MARK: - User intents
    func addRecipe(_ recipe: Recipe) {
        modelContext.insert(recipe)
        
        fetchData()
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        modelContext.delete(recipe)
        
        fetchData()
    }
    
    //MARK: - Private Helpers
    private func fetchData() {
        fetchRecipes()
        fetchFilteredRecipes()
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
    
    private func fetchRecipes() {
        do {
            let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
            
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load recipes")
        }
    }
}
