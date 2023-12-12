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
    
    var newRecipe: Recipe
    
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
                ForEach (newRecipe.instructions) { instruction in
                    Text(String(instruction.order))
                    Text(instruction.instructionDescription)
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
    
    private func addInstruction() {
        var order: Int {
            if newRecipe.instructions.count == 0 {
                    return 1
                } else {
                    return newRecipe.instructions.count + 1
                }
            }
        
        let newInstruction = RecipeInstruction(
                instructionDescription: instructionDescription,
                order: order
            )
            newRecipe.instructions.append(newInstruction)
            
            instructionDescription = ""
    }
}
