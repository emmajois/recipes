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
                    isEditingIngredient = true
                }
                .sheet(isPresented: $isEditingIngredient){
                    EditIngredientView(ingredient: ingredient)
                }
            }
            .onDelete(perform: deleteIngredient)
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
