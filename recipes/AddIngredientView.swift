//
//  AddIngredientView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/12/23.
//

import SwiftUI

struct AddIngredientView : View {
    @Environment(\.dismiss) var dismiss

    @State var ingredientName: String = ""
    @State var ingredientMeasurement: String = ""
    @State var ingredientNote: String = ""
    
    var newRecipe: Recipe
  
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Recipe Ingredients")) {
                    TextField("Name", text: $ingredientName, axis: .vertical)
                    TextField("Measurement", text: $ingredientMeasurement, axis: .vertical)
                    TextField("Additional notes (optional): ", text: $ingredientNote, axis: .vertical)
                    Section {
                        Button("Add"){
                            addIngredient()
                        }
                    }
                }
            }
            List {
                ForEach(newRecipe.ingredients) { ingredient in
                    Text(ingredient.ingredientName)
                    Text(ingredient.measurement)
                    if let note = ingredient.note {
                        Text(note).padding()
                    } else {
                        Text("").padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem{
                    Button("", systemImage: "xmark.circle") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addIngredient() {
       let newIngredient = RecipeIngredient(
            ingredientName: ingredientName,
            measurement: ingredientMeasurement,
            note: ingredientNote
        )
        
        ingredientName = ""
        ingredientMeasurement = ""
        ingredientNote = ""
        
        newRecipe.ingredients.append(newIngredient)

    }
}

