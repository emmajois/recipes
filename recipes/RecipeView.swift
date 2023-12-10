//
//  Recipe View.swift
//  recipes
//
//  Created by Emma Swalberg on 12/2/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

//MARK: - Global Vars

struct RecipeView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var recipes: [Recipe]
    @State fileprivate var showingAddRecipeSheet = false
    @State fileprivate var showingAddIngredientSheet = false
    @State fileprivate var showingAddInstructionSheet = false

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
                        Text("Breakfast")
                    } label: {
                        Text("Breakfast")
                    }
                    NavigationLink {
                        Text("Lunch")
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
    private func openAddRecipeSheet() {
        showingAddRecipeSheet.toggle()
    }
    
    private func openIngredientModal() {
        showingAddIngredientSheet.toggle()
    }
    
    private func openInstructionModal() {
        showingAddInstructionSheet.toggle()
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
                            //title
                            Text(recipe.title)
                                .font(.title)
                            .padding()
                            //metadata
                            //ingredients
                            Text("Ingredients")
                                .font(.subheadline)
                            Button(action: openIngredientModal) {
                                Label("Add Ingredients", systemImage: "plus")
                            }
                            .buttonStyle(.bordered)
                            .sheet(isPresented: $showingAddIngredientSheet) {
                                AddIngredientView(newRecipe: recipe)
                            }
                            if let ingredients = recipe.ingredients {
                                ForEach(ingredients) { ingredient in
                                    Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                                }
                            } else {
                                Text("No ingredients!").padding()
                            }
                            //instructions
                            Text("Instructions")
                                .font(.subheadline)
                            Button(action: openInstructionModal) {
                                Label("Add Instructions", systemImage: "plus")
                            }
                            .buttonStyle(.bordered)
                            .sheet(isPresented: $showingAddInstructionSheet) {
                                AddInstructionView(newRecipe: recipe)
                            }
                            if let instructions = recipe.instructions {
                                ForEach(instructions) { instruction in
                                    Text("\(instruction.order): \(instruction.instructionDescription)")
                                }
                            } else {
                                Text("No instructions!").padding()
                            }

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
                Button(action: openAddRecipeSheet) {
                    Label("Add Recipe", systemImage: "plus")
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
        @Environment(\.modelContext) private var modelContext
        
        @State var recipeTitle: String = ""
        @State var recipeAuthor: String = ""
        @State var recipeDate: Date = Date()
        @State var recipePrepTime = 5
        @State var recipeCookTime: Int = 5
        @State var recipeServings: Int = 1
        @State var recipeExpertise: Int = 1
        @State var recipeCalories: Int = 5
        @State var recipeIsFavorite: Bool = false
        @State var category: String = ""
        
        var body: some View {
            NavigationStack {
                
                ///Form help:  https://blog.logrocket.com/building-forms-swiftui-comprehensive-guide/
                
                Form {
                    Section(header: Text("Recipe Information")) {
                        TextField("Title", text: $recipeTitle)
                        TextField("Author", text: $recipeAuthor)
                        DatePicker("Date", selection: $recipeDate, displayedComponents: .date)
                        Stepper("Expertise Required: \(recipeExpertise)", value: $recipeExpertise, in: 0...10, step: 1)
                        Stepper("Minutes to prepare: \(recipePrepTime)", value: $recipePrepTime, in: 0...100, step: 5)
                        Stepper("Minutes to cook: \(recipeCookTime) ", value: $recipeCookTime, in: 0...120, step: 5)
                        Stepper("Servings: \(recipeServings)", value: $recipeServings, in: 0...50)
                        Stepper("Calories per serving: \(recipeCalories)", value: $recipeCalories, in: 0...500, step: 5)
                        Toggle(isOn: $recipeIsFavorite){
                            Text("Favorite?")
                        }
                    }
                    //TODO: Make it so multiple categories can be added
                    //picker
//                    Section(header: Text("Recipe Category")){
//                        TextField("Category", text: $category)
//                    }
                    Section {
                        Button("Submit"){
                            addRecipe()
                        }
                    }
                }
                .toolbar {
                    ToolbarItem{
                        Button("", systemImage: "xmark.circle") {
                            dismiss()
                        }
                    }
                }
            }
        }
        
        private func addRecipe() {
            withAnimation{
                let newRecipe = Recipe(
                    title: recipeTitle,
                    author: recipeAuthor,
                    date: recipeDate,
                    prepTime: recipePrepTime,
                    cookTime: recipeCookTime,
                    servings: recipeServings,
                    expertise: recipeExpertise,
                    calories: recipeCalories,
                    isFavorite: recipeIsFavorite
                )
                modelContext.insert(newRecipe)
                dismiss()
            }
        }
    }
    
    struct AddIngredientView : View {
        @Environment(\.dismiss) var dismiss

        @State var ingredientName: String = ""
        @State var ingredientMeasurement: String = ""
        @State var ingredientNote: String = ""
        
        var newRecipe: Recipe
      
        var body: some View {
            NavigationStack {
                Form {
                    Section(header: Text("Recipe Ingredients")) {
                        TextField("Name", text: $ingredientName, axis: .vertical)
                        TextField("Measurement", text: $ingredientMeasurement, axis: .vertical)
                        TextField("Additional notes (optional): ", text: $ingredientNote, axis: .vertical)
                        Section {
                            Button("Add"){
                                addIngredient()
                            }
                        }
                    }
                }
                List {
                    if let ingredients = newRecipe.ingredients {
                        ForEach(ingredients) { ingredient in
                            Text(ingredient.ingredientName)
                            Text(ingredient.measurement)
                            if let note = ingredient.note {
                                Text(note).padding()
                            } else {
                                Text("").padding()
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem{
                        Button("", systemImage: "xmark.circle") {
                            dismiss()
                        }
                    }
                }
            }
        }
        
        private func addIngredient() {
           let newIngredient = RecipeIngredient(
                ingredientName: ingredientName,
                measurement: ingredientMeasurement,
                note: ingredientNote,
                recipe: newRecipe
            )
            
            ingredientName = ""
            ingredientMeasurement = ""
            ingredientNote = ""
            
            newRecipe.ingredients?.append(newIngredient)

        }
    }
    
    struct AddInstructionView: View {
        @Environment(\.dismiss) var dismiss
        
        @State var instructionDescription: String = ""
        @State var order = 1
        
        var newRecipe: Recipe
        
        var body: some View {
            NavigationStack {
                Form {
                    Section(header: Text("Recipe Instructions")) {
                        TextField("Instructions", text: $instructionDescription, axis: .vertical)
                    }
                    Section {
                        Button("Add"){
                            addInstruction()
                        }
                    }
                }
                List {
                    if let instructions = newRecipe.instructions {
                        ForEach (instructions) { instruction in
                            Text(String(instruction.order))
                            Text(instruction.instructionDescription)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem{
                        Button("", systemImage: "xmark.circle") {
                            dismiss()
                        }
                    }
                }
            }
        }
        
        private func addInstruction() {
            let newInstruction = RecipeInstruction(
                instructionDescription: instructionDescription,
                order: order,
                recipe: nil
            )
            
            instructionDescription = ""
            
            newRecipe.instructions?.append(newInstruction)
            order+=1
        }
    }
}

#Preview {
    RecipeView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
