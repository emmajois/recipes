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
                        Text("\(ingredient.ingredientName): \(ingredient.measurement)").padding()
                    } else {
                        Text("\(ingredient.ingredientName): \(ingredient.measurement) - \(note)").padding()
                    }
                } else {
                    Text("\(ingredient.ingredientName): \(ingredient.measurement)").padding()
                }
                Button("", systemImage: "pencil") {
                    selectedIngredient = ingredient
                    isEditingIngredient = true
                }
                .onChange(of: selectedIngredient) {
                    isEditingIngredient = selectedIngredient != nil
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
    
    private func deleteIngredient(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                recipeIngredients.remove(at:index)
            }
        }
    }
}

