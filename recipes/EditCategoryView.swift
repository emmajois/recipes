//
//  EditCategoryView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/13/23.
//
/// Figured out how to bring up an edit sheet in the correct place: https://stackoverflow.com/questions/61176412/can-t-pass-data-correctly-to-modal-presentation-using-foreach-and-coredata-in-sw

import SwiftUI

struct EditCategoryView: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.dismiss) var dismiss
    
    let category : RecipeCategory
    
    @State var categoryName: String = ""
    
    
    init(category: RecipeCategory) {
        self.category = category
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Edit Category")){
                    TextField("Category Name", text: $categoryName)
                }
                if category.recipes != [] {
                    Section(header: Text("Slide to Remove Recipes from Category")){
                        List{
                            ForEach(category.recipes){ recipe in
                                Text(recipe.title)
                            }
                            .onDelete(perform: deleteRecipe)
                        }
                    }
                }
            }
            .navigationTitle("Edit Category")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        updateCategory()
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
        .onAppear{
            categoryName = category.categoryName
        }
    }
    
    //MARK: - Functions
    private func deleteRecipe(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                category.recipes.remove(at:index)
            }
        }
        
        viewModel.saveData()
    }
    
    private func updateCategory() {
        category.categoryName = categoryName
        
        viewModel.saveData()
    }
}
