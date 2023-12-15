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
    @State var instructionOrder: Int = 0
    
    @Binding var recipeInstructions: [RecipeInstruction]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Add new Instruction")) {
                    TextField("Instructions", text: $instructionDescription, axis: .vertical)
                    Stepper("Step Number: \(instructionOrder)", value: $instructionOrder, in: 0...100, step: 1)
                    Button("Add"){
                        addInstruction()
                    }
                }
                Section {
                    InstructionListView(recipeInstructions: $recipeInstructions)
                }
            }
            .navigationTitle(instructionTitle)
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
    
    //MARK: - Functions & Computed Properties
    private var instructionTitle: String {
        recipeInstructions.count == 0 ? "Add instructions" : "Edit instructions"
    }
    
    private func addInstruction() {
        let newInstruction = RecipeInstruction(
            instructionDescription: instructionDescription,
            order: instructionOrder
        )
        
        instructionDescription = ""
        instructionOrder+=1
        
        recipeInstructions.append(newInstruction)
    }
}
