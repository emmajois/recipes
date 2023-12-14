//
//  EditIngredientView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/13/23.
//

import SwiftUI

struct EditIngredientView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var ingredientName: String = ""
    @State var ingredientMeasurement: String = ""
    @State var ingredientNote: String = ""
    
    let ingredient: RecipeIngredient
    
    init(ingredient: RecipeIngredient) {
        self.ingredient = ingredient
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Recipe Ingredients")) {
                    TextField("Name", text: $ingredientName, axis: .vertical)
                    TextField("Measurement", text: $ingredientMeasurement, axis: .vertical)
                    TextField("Additional notes (optional): ", text: $ingredientNote, axis: .vertical)
                }
            }
            .navigationTitle("Edit Ingredients")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        saveIngredient()
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
        .onAppear {
            ingredientName = ingredient.ingredientName
            ingredientMeasurement = ingredient.measurement
            if let ingredientNotePassed = ingredient.note {
                ingredientNote = ingredientNotePassed
            }
        }
    }

    private func saveIngredient() {
        ingredient.ingredientName = ingredientName
        ingredient.measurement = ingredientMeasurement
        ingredient.note = ingredientNote
        
        dismiss()
    }
}

