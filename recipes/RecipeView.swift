//
//  Recipe View.swift
//  recipes
//
//  Created by Emma Swalberg on 12/2/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct RecipeView: View {
    //MARK: - Properties
    @State private var viewModel: ViewModel
    @State private var hasError = false
    @State private var errorMessage = ""
    
    //MARK: - Initialize
    init(_ modelContext: ModelContext) {
        _viewModel = State(initialValue: ViewModel(modelContext))
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                // A section for browse, search, favorites
                Section(header: Text("Actions")) {
                    NavigationLink {
                        RecipeListView(recipeList: viewModel.recipes)
                    } label: {
                        Label("Browse All", systemImage: "list.bullet")
                    }
                    NavigationLink {
                       SearchPageView(recipes: viewModel.recipes)
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    NavigationLink {
                        RecipeListView(recipeList: viewModel.favoriteRecipes)
                    } label: {
                        Label("Favorites", systemImage: "star.fill")
                    }
                }
                // A section for all the categories
                Section(header: Text("Categories")) {
                    ForEach(viewModel.categories) { category in
                        NavigationLink {
                            if category.recipes == [] {
                                Text("No recipes under \(category.categoryName)")
                            } else {
                                RecipeListView(recipeList: viewModel.recipes.filter{$0.categories.contains(where: {$0.categoryName == category.categoryName})})
                            }
                        } label: {
                            Text(category.categoryName)
                        }
                    }
                }
                // A section for the edit category view
                Section(header: Text("Edit Categories")) {
                    NavigationLink{
                        ManageCategoryView()
                    } label: {
                        Text("Edit Categories")
                    }
                }
            }
        } content: {
            RecipeListView(recipeList: viewModel.recipes)

        } detail: {
            Text("Select a recipe")
        }
        .alert(isPresented: $hasError) {
            Alert(
                title: Text("Unable to Reset Database"),
                message: Text(errorMessage)
            )
        }
        .task {
            if viewModel.recipes.isEmpty {
                withAnimation {
                    do {
                        try viewModel.replaceAllRecipes(emmaSampleRecipes, baseCategories, sampleAssociations)
                    } catch {
                        errorMessage = error.localizedDescription
                        hasError = true
                    }
                }
            }
        }
        .environment(viewModel)
    }
}

#Preview {
    let container = { () -> ModelContainer in
        do {
            return try ModelContainer(
                for: Recipe.self, RecipeCategory.self,
                configurations:
                    ModelConfiguration(isStoredInMemoryOnly: true)
                )
        } catch {
            fatalError("Failed to create ModelContainer for Recipes.")
        }
    } ()
    return RecipeView(container.mainContext)
        .modelContainer(container)
}
