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
    //MARK: - Properties
    @State private var viewModel: ViewModel
    @State private var hasError = false
    @State private var errorMessage = ""
    
    @State fileprivate var showingAddRecipeSheet = false
    @State fileprivate var showingAddIngredientSheet = false
    @State fileprivate var showingAddInstructionSheet = false
    
    //MARK: - Initialize
    init(_ modelContext: ModelContext) {
        _viewModel = State(initialValue: ViewModel(modelContext))
    }
    
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
                    ForEach(viewModel.categories) { category in
                        NavigationLink {
                            Text(category.categoryName)
                        } label: {
                            Text(category.categoryName)
                        }
                    }
                }
            }
        } content: {
            browseAllList

        } detail: {
            Text("Select an item")
        }
        .alert(isPresented: $hasError) {
            Alert(
                title: Text("Unable to Reset Database"),
                message: Text(errorMessage)
            )
        }
        .task {
            if viewModel.recipes.isEmpty {
                withAnimation {
                    do {
                        try viewModel.replaceAllRecipes(emmaSampleRecipes, baseCategories, sampleAssociations)
                    } catch {
                        errorMessage = error.localizedDescription
                        hasError = true
                    }
                }
            }
        }
        .environment(viewModel)
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

    private func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                viewModel.deleteRecipe(viewModel.recipes[index])
            }
        }
    }
    
// MARK: - Variables
    private var browseAllList: some View {
        List {
            ForEach(viewModel.recipes) { recipe in
                NavigationLink {
                    ScrollView {
                        VStack {
                            //title
                            Text(recipe.title)
                                .font(.title)
                            .padding()
                            //metadata
                            //categories
                            ForEach(recipe.categories) {category in
                                Text(category.categoryName)
                            }
                            //ingredients
                            //TODO: - Order the lists both inside and outside
                            Text("Ingredients")
                                .font(.subheadline)
                            Button(action: openIngredientModal) {
                                Label("Add Ingredients", systemImage: "plus")
                            }
                            .buttonStyle(.bordered)
                            .sheet(isPresented: $showingAddIngredientSheet) {
                                AddIngredientView(newRecipe: recipe)
                            }
                            if recipe.ingredients.count > 0 {
                                ForEach(recipe.ingredients) { ingredient in
                                    Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                                }
                            } else {
                                Text("No ingredients!").padding()
                            }
                            //instructions
                            //TODO: - Order the lists both inside and outside
                            Text("Instructions")
                                .font(.subheadline)
                            Button(action: openInstructionModal) {
                                Label("Add Instructions", systemImage: "plus")
                            }
                            .buttonStyle(.bordered)
                            .sheet(isPresented: $showingAddInstructionSheet) {
                                AddInstructionView(newRecipe: recipe)
                            }
                            if recipe.instructions.count > 0 {
                                ForEach(recipe.instructions.sorted(by: { $0.order < $1.order })) { instruction in
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
            .onDelete(perform: deleteRecipes)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
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
                    ForEach(newRecipe.ingredients) { ingredient in
                        Text(ingredient.ingredientName)
                        Text(ingredient.measurement)
                        if let note = ingredient.note {
                            Text(note).padding()
                        } else {
                            Text("").padding()
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
                note: ingredientNote
            )
            
            ingredientName = ""
            ingredientMeasurement = ""
            ingredientNote = ""
            
            newRecipe.ingredients.append(newIngredient)

        }
    }
    
    struct AddInstructionView: View {
        @Environment(\.dismiss) var dismiss
        
        @State var instructionDescription: String = ""
        
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
                    ForEach (newRecipe.instructions) { instruction in
                        Text(String(instruction.order))
                        Text(instruction.instructionDescription)
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
            var order: Int {
                if newRecipe.instructions.count == 0 {
                        return 1
                    } else {
                        return newRecipe.instructions.count + 1
                    }
                }
            
            let newInstruction = RecipeInstruction(
                    instructionDescription: instructionDescription,
                    order: order
                )
                newRecipe.instructions.append(newInstruction)
                
                instructionDescription = ""
        }
    }
}

#Preview {
    let container = { () -> ModelContainer in
        do {
            return try ModelContainer(
                for: Recipe.self, RecipeCategory.self,
                configurations:
                    ModelConfiguration(isStoredInMemoryOnly: true)
                )
        } catch {
            fatalError("Failed to create ModelContainer for Recipes.")
        }
    } ()
    return RecipeView(container.mainContext)
        .modelContainer(container)
}
