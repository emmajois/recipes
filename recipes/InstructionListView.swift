//
//  InstructionListView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/13/23.
//

import SwiftUI

struct InstructionListView: View {
    @Binding var recipeInstructions : [RecipeInstruction]
    
    var body: some View {
        List {
            ForEach (recipeInstructions) { instruction in
                Text(String("\(instruction.order). \(instruction.instructionDescription)"))
            }
            .onDelete(perform: deleteInstruction)
        }
    }
    
    private func deleteInstruction(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                recipeInstructions.remove(at:index)
            }
            fixOrder()
        }
        
        func fixOrder() {
            var newOrder = 1
            
            recipeInstructions.forEach { instruction in
                instruction.order = newOrder
                newOrder+=1
            }
        }
    }
}
