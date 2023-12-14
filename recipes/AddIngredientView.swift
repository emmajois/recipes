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
                Section(header: Text("Add New Ingredient")) {
                    TextField("Name", text: $ingredientName, axis: .vertical)
                    TextField("Measurement", text: $ingredientMeasurement, axis: .vertical)
                    TextField("Additional notes (optional): ", text: $ingredientNote, axis: .vertical)
                    Button("Add"){
                        addIngredient()
                    }
                }
                Section{
                    IngredientListView(recipeIngredients: $recipeIngredients)
                }
            }
            .navigationTitle(ingredientTitle)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
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
    
    private var ingredientTitle: String {
        recipeIngredients.count == 0 ? "Add ingredients" : "Edit ingredients"
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
        
        recipeIngredients.append(newIngredient)
    }
}

