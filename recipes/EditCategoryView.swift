//
//  EditCategoryView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/13/23.
//

import SwiftUI

struct EditCategoryView: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.dismiss) var dismiss
    
    @State var categoryName: String = ""
    
    let category : RecipeCategory
    
    init(category: RecipeCategory) {
        self.category = category
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Edit Category")){
                    TextField("Category Name", text: $categoryName)
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
    
    private func updateCategory() {
        category.categoryName = categoryName
        
        viewModel.saveCategory()
    }
}
