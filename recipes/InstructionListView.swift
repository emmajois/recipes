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
    //when deleting, go and reorder and save the new orders to them, loop that
    private func deleteInstruction(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                recipeInstructions.remove(at:index)
            }
        }
    }
}
