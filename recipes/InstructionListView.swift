//
//  InstructionListView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/13/23.
//

import SwiftUI

struct InstructionListView: View {
    @Binding var recipeInstructions : [RecipeInstruction]
    
    @State var isEditingInstruction : Bool = false
    @State var selectedInstruction : RecipeInstruction? = nil
    
    var body: some View {
        List {
            ForEach (recipeInstructions) { instruction in
                HStack{
                    Text(String("\(instruction.order). \(instruction.instructionDescription)"))
                    Button("", systemImage: "pencil") {
                        updateSelectedInstruction(newSelectedInstruction: instruction)
                    }
                    .onChange(of: selectedInstruction) {
                        isEditingInstruction = selectedInstruction != nil
                    }
                }
            }
            .onDelete(perform: deleteInstruction)
            .sheet(isPresented: $isEditingInstruction){
                if let selectedInstruction {
                    EditInstructionView(instruction: selectedInstruction)
                }
            }
        }
    }
    
    //MARK: - Functions
    private func updateSelectedInstruction(newSelectedInstruction: RecipeInstruction) {
        selectedInstruction = newSelectedInstruction
    }
    
    private func deleteInstruction(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                recipeInstructions.remove(at:index)
            }
            
            fixOrder()
        }
    }
    
    private func fixOrder() {
        var newOrder = 1
        
        recipeInstructions.forEach { instruction in
            instruction.order = newOrder
            newOrder+=1
        }
    }
}
