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
    
    @Binding var recipeIngredients: [RecipeIngredient]
  
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
                ForEach(recipeIngredients) { ingredient in
                    Text(ingredient.ingredientName)
                    Text(ingredient.measurement)
                    if let note = ingredient.note {
                        Text(note).padding()
                    } else {
                        Text("").padding()
                    }
                }
            }
            //.navigationTitle(formTitle)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
//                        if let recipe {
//                            editRecipe(recipeToEdit: recipe)
//                        } else {
//                            addRecipe()
//                        }
                        dismiss()
                    }, label: {
                            Text("Save")
                    })
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("", systemImage: "xmark.circle") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    //private var formTitle = "Add Ingredients"
    
    private func addIngredient() {
       let newIngredient = RecipeIngredient(
            ingredientName: ingredientName,
            measurement: ingredientMeasurement,
            note: ingredientNote
        )
        
        ingredientName = ""
        ingredientMeasurement = ""
        ingredientNote = ""
        recipeIngredients.append(newIngredient)

    }
}

