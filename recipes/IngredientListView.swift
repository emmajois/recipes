//
//  IngredientListView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/13/23.
//

import SwiftUI

struct IngredientListView: View {
    @Binding var recipeIngredients: [RecipeIngredient]
    
    @State var isEditingIngredient = false
    @State var selectedIngredient : RecipeIngredient? = nil
    
    var body: some View {
        List {
            ForEach(recipeIngredients) { ingredient in
                if let note = ingredient.note {
                    if note.isEmpty {
                        HStack{
                            Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                            Button("", systemImage: "pencil") {
                                editIngredient(ingredient: ingredient)
                            }
                            .onChange(of: selectedIngredient) {
                                isEditingIngredient = selectedIngredient != nil
                            }
                        }
                    } else {
                        HStack{
                            Text("\(ingredient.ingredientName): \(ingredient.measurement) - \(note)")
                            Button("", systemImage: "pencil") {
                                editIngredient(ingredient: ingredient)
                            }
                            .onChange(of: selectedIngredient) {
                                isEditingIngredient = selectedIngredient != nil
                            }
                        }
                    }
                } else {
                    HStack{
                        Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                        Button("", systemImage: "pencil") {
                            editIngredient(ingredient: ingredient)
                        }
                        .onChange(of: selectedIngredient) {
                            isEditingIngredient = selectedIngredient != nil
                        }
                    }
                }
            }
            .onDelete(perform: deleteIngredient)
            .sheet(isPresented: $isEditingIngredient){
                if let selectedIngredient {
                    EditIngredientView(ingredient: selectedIngredient)
                }
            }
        }
    }
    
    //MARK: - Functions
    private func editIngredient(ingredient: RecipeIngredient) {
        selectedIngredient = ingredient
        isEditingIngredient = true
    }
    
    private func deleteIngredient(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                recipeIngredients.remove(at:index)
            }
        }
    }
}

