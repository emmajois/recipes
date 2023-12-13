//
//  AddInstructionView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/12/23.
//

import SwiftUI

struct AddInstructionView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var instructionDescription: String = ""
    
    @Binding var recipeInstructions: [RecipeInstruction]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Recipe Instructions")) {
                    TextField("Instructions", text: $instructionDescription, axis: .vertical)
                }
                Section {
                    Button("Add"){
                        addInstruction()
                    }
                }
            }
            List {
                ForEach (recipeInstructions) { instruction in
                    Text(String(instruction.order))
                    Text(instruction.instructionDescription)
                }
            }
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
    
    private func addInstruction() {
        var order: Int {
            if recipeInstructions.count == 0 {
                    return 1
                } else {
                    return recipeInstructions.count + 1
                }
            }
        
        let newInstruction = RecipeInstruction(
                instructionDescription: instructionDescription,
                order: order
            )
            recipeInstructions.append(newInstruction)
            
            instructionDescription = ""
    }
}
