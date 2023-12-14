//
//  ManageCategoryView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/13/23.
//

import SwiftUI

struct ManageCategoryView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State var categoryName = ""
    
    var body: some View {
        List{
            ForEach(viewModel.categories) { category in
                Text(category.categoryName)
            }
            .onDelete(perform: deleteCategory)
        }
        Form {
            Section(header: Text("New Category")){
                TextField("Category Name", text: $categoryName)
                Button("Add"){
                    addCategory()
                }
            }
        }
    }
    
    private func addCategory() {
        let newCategory = RecipeCategory(categoryName: categoryName)

        viewModel.addCategory(newCategory)
        
        categoryName = ""
    }
    
    private func deleteCategory(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                viewModel.deleteCategory(viewModel.categories[index])
            }
        }
    }
}

#Preview {
    ManageCategoryView()
}
