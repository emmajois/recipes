//
//  Recipe View.swift
//  recipes
//
//  Created by Emma Swalberg on 12/2/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct RecipeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recipes: [Recipe]
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
                modelContext.delete(recipes[index])
            }
        }
    }
    
    private func initializeRecipes() {
        withAnimation {
            // TODO: Make this automatically load them in with correct fields
            //        for recipe in sampleRecipes {
            //            modelContext.insert(recipe)
            //        }
//            if let recipes = loadJson(filename: "SampleData") {
//                for recipe in recipes {
//                    modelContext.insert(Recipe(
//                        title: recipe.title
//                        ingredients: recipe.ingredients,
//                        instructions: recipe.instructions
//                    ))
//                }
//            }
        }
    }
    
// MARK: - Variables
    private var browseAllList: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink {
                    ScrollView {
                        VStack {
                            Markdown {
                                recipe.title
                            }
                            .padding()
                            Markdown {
                                //item.ingredients
                            }
                            .padding()
                            Markdown {
                                //item.instructions
                            }
                            .padding()
                        }
                    }
                } label: {
                    Text(recipe.title)
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
        @State var recipeAuthor: String = ""
        @State var recipeExpertise: String = ""
        @State var recipeDate: Date = Date()
        @State var recipePrepTime = 5
        @State var recipeCookTime: Int = 5
        @State var recipeServings: Int = 1
        @State var recipeCalories: Int = 1
        @State var recipeIsFavorite: Bool = false
        @State var ingredientName: String = ""
        @State var ingredientMeasurement: String = ""
        @State var ingredientNote: String = ""
        @State var instructionDescription: String = ""
        @State var category: String = ""
        
        var body: some View {
            NavigationStack {
                
                ///Form help:  https://blog.logrocket.com/building-forms-swiftui-comprehensive-guide/
                
                Form {
                    Section(header: Text("Recipe Information")) {
                        TextField("Title", text: $recipeTitle)
                        TextField("Author", text: $recipeAuthor)
                        DatePicker("Date", selection: $recipeDate, displayedComponents: .date)
                        Stepper("Minute to prepare: \(recipePrepTime)", value: $recipePrepTime, in: 0...100, step: 5)
                        Stepper("Minutes to cook: \(recipeCookTime) ", value: $recipeCookTime, in: 0...120, step: 5)
                        Stepper("Servings: \(recipeServings)", value: $recipeServings, in: 0...50)
                        Stepper("Calories per serving: \(recipeCalories)", value: $recipeCalories, in: 0...500, step: 5)
                        Toggle(isOn: $recipeIsFavorite){
                            Text("Favorite?")
                        }
                    }
                    //TODO: Make it so the form duplicates if they want to add an additional ingredient
                    Section(header: Text("Recipe Ingredients")) {
                        TextField("Name", text: $ingredientName)
                        TextField("Measurement", text: $ingredientMeasurement)
                        TextField("Additional notes (optional): ", text: $ingredientNote)
                    }
                    //TODO: Make the form duplicate if they have extra steps
                    Section(header: Text("Recipe Instructions")) {
                        TextField("Instructions", text: $instructionDescription)
                        //order will have to be auto incremented for each new instruction
                    }
                    //TODO: Make it so multiple categories can be added
                    Section(header: Text("Recipe Category")){
                        TextField("Category", text: $category)
                    }
                }
            }
            //TODO: Figure out why the toolbar isn't showing up on the form
            .toolbar {
                ToolbarItem{
                    Button("", systemImage: "xmark.circle") {
                        dismiss()
                    }
                }
            }
        }
    }
}



#Preview {
    RecipeView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
