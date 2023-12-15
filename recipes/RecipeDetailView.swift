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
    
    var recipe: Recipe
    
    var body: some View {
            ScrollView {
                VStack {
                    //title
                    HStack{
                        Text(recipe.title)
                            .font(.title)
                        .padding()
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
                    //metadata
                    //TODO: ADD METADATA TO THE VIEW
                    //categories
                    HStack {
                        ForEach(recipe.categories) {category in
                            VStack{
                                Button(category.categoryName, systemImage: "xmark.circle") {
                                    //toggleIsFavorite(recipeToToggle: recipe)
                                }.padding()
                                //Text(category.categoryName)
                                    .background(Capsule().fill(.white).stroke(.blue))
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    //ingredients
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
        }
    
    private func toggleIsFavorite(recipeToToggle: Recipe) {
        recipeToToggle.isFavorite.toggle()
        
        viewModel.saveData()
    }
}


