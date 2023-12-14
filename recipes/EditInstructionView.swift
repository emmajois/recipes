//
//  EditInstructionView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/14/23.
//

import SwiftUI

struct EditInstructionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ViewModel.self) private var viewModel
    
    let instruction: RecipeInstruction
    
    @State var instructionDescription: String = ""
    @State var instructionOrder: Int = 0
    
    init(instruction: RecipeInstruction){
        self.instruction = instruction
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Recipe Instructions")) {
                    TextField("Instructions", text: $instructionDescription, axis: .vertical)
                    Stepper("Step Number: \(instructionOrder)", value: $instructionOrder, in: 0...100, step: 1)
                }
            }
            
            .navigationTitle("Edit Instructions")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        saveInstruction()
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
            instructionDescription = instruction.instructionDescription
            instructionOrder = instruction.order
        }
    }
    
    private func saveInstruction() {
        instruction.instructionDescription = instructionDescription
        instruction.order = instructionOrder
        
        viewModel.saveData()
    
        dismiss()
    }
}
