//
//  ManageCategoryView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/13/23.
//

import SwiftUI

struct ManageCategoryView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State var categoryName: String = ""
    @State var isEditingCategory: Bool = false
    @State var selectedCategory: RecipeCategory? = nil
    
    var body: some View {
        List{
            ForEach(viewModel.categories) { category in
                Button(category.categoryName, systemImage: "pencil") {
                    updateSelectedCategory(newSelectedCategory: category)
                }
                .onChange(of: selectedCategory) {
                    isEditingCategory = selectedCategory != nil
                }
            }
            .onDelete(perform: deleteCategory)
            .sheet(isPresented: $isEditingCategory){
                EditCategoryView(category: selectedCategory)
            }
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
    
    private func updateSelectedCategory(newSelectedCategory: RecipeCategory) {
        selectedCategory = newSelectedCategory
    }
    
    private func addCategory() {
        let newCategory = RecipeCategory(categoryName: categoryName)

        var isNotDuplicate = true
        
        viewModel.categories.forEach { category in
            if newCategory.categoryName == category.categoryName || newCategory.categoryName.isEmpty {
                isNotDuplicate = false
            }
        }
        
        if isNotDuplicate {
            viewModel.addCategory(newCategory)
        }
        
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
