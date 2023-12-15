//
//  recipeDetailView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/14/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var isEditing = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack {
                //title
                VStack{
                    HStack{
                        Text(recipe.title)
                            .font(.title)
                        if recipe.isFavorite {
                            Button("", systemImage: "star.fill") {
                                toggleIsFavorite(recipeToToggle: recipe)
                            }
                        } else {
                            Button("", systemImage: "star") {
                                toggleIsFavorite(recipeToToggle: recipe)
                            }
                        }
                    }
                    .padding()
                    Text("By: \(recipe.author)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Added on: \(recipe.date.formatted(.dateTime.day().month().year()))")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                //categories
                    VStack {
                        LazyVGrid (columns: columns) {
                            ForEach(recipe.categories) {category in
                                VStack{
                                    Button(category.categoryName, systemImage: "xmark.circle") {
                                        deleteCategory(categoryToDelete: category)
                                    }
                                    .padding()
                                    .background(Capsule().fill(.white).stroke(.blue))
                                    .foregroundStyle(.blue)
                                }
                            }
                        }
                    }
                //metadata
                VStack{
                    Text("Recipe Information")
                        .font(.headline)
                    Text("Preperation Time: \(recipe.prepTime)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Cook Time: \(recipe.cookTime)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Calories per Serving: \(recipe.calories)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Servings: \(recipe.servings)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Expertise Required: \(recipe.expertise)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                //ingredients
                VStack {
                    Text("Ingredients")
                        .font(.headline)
                    if recipe.ingredients.count > 0 {
                        ForEach(recipe.ingredients.sorted(by: { $0.ingredientName < $1.ingredientName })) { ingredient in
                            if let note = ingredient.note {
                                if note.isEmpty {
                                    Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } else {
                                    Text("\(ingredient.ingredientName): \(ingredient.measurement) - \(note)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            } else {
                                Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    } else {
                        Text("No ingredients!").padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                //instructions
                VStack{
                    Text("Instructions")
                        .font(.headline)
                    if recipe.instructions.count > 0 {
                        ForEach(recipe.instructions.sorted(by: { $0.order < $1.order })) { instruction in
                            Text("\(instruction.order): \(instruction.instructionDescription)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    } else {
                        Text("No instructions!").padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
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
            .sheet(isPresented: $isEditing) {
                AddSheetView(recipe: recipe)
            }
        }
    }
    
    //MARK: - Functions
    private func toggleIsFavorite(recipeToToggle: Recipe) {
        recipeToToggle.isFavorite.toggle()
        
        viewModel.saveData()
    }
    
    private func deleteCategory(categoryToDelete: RecipeCategory) {
        recipe.categories.removeAll { category in
            category == categoryToDelete
        }
        
        viewModel.saveData()
    }
}


