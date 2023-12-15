//
//  SearchPageView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/14/23.
//
// Search Bar help: https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-a-search-bar-to-filter-your-data

import SwiftUI

struct SearchPageView: View {
    @State private var searchText = ""
    
    var recipes: [Recipe]
    
    var body: some View {
        List {
            ForEach(searchResults, id:\.self) { recipe in
                NavigationLink {
                    Text(recipe.title)
                } label: {
                    Text(recipe.title)
                }
            }
        }
        .navigationTitle("Search Recipes by Title")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always ))
    }
    
    var searchResults: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {$0.title.contains(searchText)}
        }
    }
}
