//
//  RecipeListView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/14/23.
//

import SwiftUI

struct RecipeListView: View {
    @Environment(ViewModel.self) private var viewModel
    
    let recipeList : [Recipe]
    
    @State private var showingAddRecipeSheet = false
    
    var body: some View {
        List {
            ForEach(recipeList) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe)
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
}
