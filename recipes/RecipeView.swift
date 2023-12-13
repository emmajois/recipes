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
    @State private var isEditing = false
    
    @State fileprivate var showingAddRecipeSheet = false
    @State fileprivate var showingAddInstructionSheet = false
    
    //MARK: - Initialize
    init(_ modelContext: ModelContext) {
        _viewModel = State(initialValue: ViewModel(modelContext))
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                // a section for browse, search, favorites
                Section(header: Text("Actions")) {
                    NavigationLink {
                        browseAllList
                    } label: {
                        Label("Browse All", systemImage: "list.bullet")
                    }
                    NavigationLink {
                        Text("Search page")
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    NavigationLink {
                        Text("All favorites")
                    } label: {
                        Label("Favorites", systemImage: "star.fill")
                    }
                }
                // all the categories
                Section(header: Text("Categories")) {
                    ForEach(viewModel.categories) { category in
                        NavigationLink {
                            Text(category.categoryName)
                        } label: {
                            Text(category.categoryName)
                        }
                    }
                }
            }
        } content: {
            browseAllList

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
    
//MARK: - Functions
    private func openAddRecipeSheet() {
        showingAddRecipeSheet.toggle()
    }
    
    private func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                viewModel.deleteRecipe(viewModel.recipes[index])
            }
        }
    }
    
// MARK: - Variables
    private var browseAllList: some View {
        List {
            ForEach(viewModel.recipes) { recipe in
                NavigationLink {
                    ScrollView {
                        VStack {
                            //title
                            Text(recipe.title)
                                .font(.title)
                            .padding()
                            //metadata
                            //categories
                            ForEach(recipe.categories) {category in
                                Text(category.categoryName)
                            }
                            //ingredients
                            //TODO: - Order the lists both inside and outside
                            Text("Ingredients")
                                .font(.subheadline)
                            if recipe.ingredients.count > 0 {
                                ForEach(recipe.ingredients.sorted(by: { $0.ingredientName < $1.ingredientName })) { ingredient in
                                    Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                                }
                            } else {
                                Text("No ingredients!").padding()
                            }
                            //instructions
                            //TODO: - Order the lists both inside and outside
                            Text("Instructions")
                                .font(.subheadline)
                            if recipe.instructions.count > 0 {
                                ForEach(recipe.instructions.sorted(by: { $0.order < $1.order })) { instruction in
                                    Text("\(instruction.order): \(instruction.instructionDescription)")
                                }
                            } else {
                                Text("No instructions!").padding()
                            }

                        }
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button(action: {
                                    isEditing = true
                                }, label: {
                                    Label("Edit Item", systemImage: "pencil")
                                })
                            }
                        }
                        .sheet(isPresented: $isEditing){
                            AddSheetView(recipe: recipe)
                        }
                    }
                } label: {
                    Text(recipe.title)
                }
            }
            .onDelete(perform: deleteRecipes)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: openAddRecipeSheet) {
                    Label("Add Recipe", systemImage: "plus")
                }
                .sheet(isPresented: $showingAddRecipeSheet) {
                    AddSheetView(recipe: nil)
                }
            }
        }
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
