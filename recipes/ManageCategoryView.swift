//
//  ManageCategoryView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/13/23.
//

import SwiftUI

struct ManageCategoryView: View {
    @Environment(ViewModel.self) private var viewModel
    
    var body: some View {
        List{
            ForEach(viewModel.categories) { category in
                Text(category.categoryName)
            }
            .onDelete(perform: deleteCategory)
        }
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
