//
//  ContentView.swift
//  recipes
//
//  Created by Emma Swalberg on 11/21/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State fileprivate var showingAddRecipeSheet = false

    var body: some View {
        NavigationSplitView {
            List {
                // a section for browse, search, favorites
                Section(header: Text("Actions")) {
                    NavigationLink {
                        browseAllList
                    } label: {
                        Label("Browse All", systemImage: "list.bullet")
                    }
                    NavigationLink {
                        Text("Search page")
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    NavigationLink {
                        Text("All favorites")
                    } label: {
                        Label("Favorites", systemImage: "star.fill")
                    }
                }
                // all the categories
                Section(header: Text("Categories")) {
                    NavigationLink {
                        Text("breakfast")
                    } label: {
                        Text("Breakfast")
                    }
                    NavigationLink {
                        Text("lunch")
                    } label: {
                        Text("Lunch")
                    }
                    NavigationLink {
                        Text("Dinner")
                    } label: {
                        Text("Dinner")
                    }
                }
            }
        } content: {
            browseAllList

        } detail: {
            Text("Select an item")
        }
    }
    
//MARK: - Functions
    private func addItem() {
        // TODO: redo the new item logic
//        withAnimation {
//            let newItem = Item(title: "Some Item", ingredients: "Some stuff", instructions: "Do something")
//            modelContext.insert(newItem)
//        }
        showingAddRecipeSheet.toggle()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func initializeRecipes() {
        withAnimation {
            // TODO: Make this automatically load them in
            //        for recipe in sampleRecipes {
            //            modelContext.insert(recipe)
            //        }
            if let recipes = loadJson(filename: "SampleData") {
                for recipe in recipes {
                    modelContext.insert(Item(
                        title: recipe.title,
                        ingredients: recipe.ingredients,
                        instructions: recipe.instructions
                    ))
                }
            }
        }
    }
    
// MARK: - Variables
    private var browseAllList: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    ScrollView {
                        VStack {
                            Markdown {
                                item.title
                            }
                            .padding()
                            Markdown {
                                item.ingredients
                            }
                            .padding()
                            Markdown {
                                item.instructions
                            }
                            .padding()
                        }
                    }
                } label: {
                    Text(item.title)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: initializeRecipes){
                    Label("Initialize", systemImage: "folder.badge.plus")
                }
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
                .sheet(isPresented: $showingAddRecipeSheet) {
                    AddSheetView()
                }
            }
        }
    }

// MARK: - Structs
    struct AddSheetView: View {
        @Environment(\.dismiss) var dismiss
        @State var recipeTitle: String = ""
        @State var ingredients: String = ""
        @State var instructions: String = ""
        
        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("Recipe Information")) {
                        TextField("Recipe Title", text: $recipeTitle)
                        //all the rest of the metadata that will be added
                    }
                    Section(header: Text("Recipe Ingredients")) {
                        TextField("Ingredients", text: $ingredients)
                        //Rest that goes with the recipes
                    }
                    Section(header: Text("Recipe Instructions")) {
                        TextField("Instructions", text: $instructions)
                        //Rest that will go with instructions
                    }
                }
            }
            //TODO: Figure out why the toolbar isn't showing up on the form
            .toolbar {
                ToolbarItem{
                    Button("test", systemImage: "xmark.circle") {
                        dismiss()
                    }
                }
            }
        }
    }
}



#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
