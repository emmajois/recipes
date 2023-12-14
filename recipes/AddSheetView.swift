//
//  AddSheetView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/12/23.
//

import SwiftUI

struct AddSheetView: View {
    //Environment vars
    @Environment(\.dismiss) var dismiss
    @Environment(ViewModel.self) private var viewModel
    
    let recipe: Recipe?
    
    //All the recipe fields
    @State var recipeTitle: String = ""
    @State var recipeAuthor: String = ""
    @State var recipeDate: Date = Date()
    @State var recipePrepTime = 5
    @State var recipeCookTime: Int = 5
    @State var recipeServings: Int = 1
    @State var recipeExpertise: Int = 1
    @State var recipeCalories: Int = 5
    @State var recipeIsFavorite: Bool = false
    @State var recipeCategory: Set<RecipeCategory> = []
    @State var recipeCategories: [RecipeCategory] = []
    @State var recipeIngredients: [RecipeIngredient] = []
    @State var recipeInstructions: [RecipeInstruction] = []
    
    //Nested Sheets
    @State private var showingAddIngredientSheet = false
    @State private var showingAddInstructionSheet = false
    
    init(recipe: Recipe?) {
        self.recipe = recipe
    }
    
    var body: some View {
        NavigationStack {
            
            ///Form help:  https://blog.logrocket.com/building-forms-swiftui-comprehensive-guide/
            
            Form {
                //Recipe metadata
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
                //Ingredients
                Section(header: Text("Ingredients")) {
                    Button(action: openIngredientModal) {
                        Label(ingredientTitle, systemImage: "plus")
                    }
                    .sheet(isPresented: $showingAddIngredientSheet) {
                        AddIngredientView(recipeIngredients: $recipeIngredients)
                    }
                    IngredientListView(recipeIngredients: $recipeIngredients)
                }
                //Instructions
                Section(header: Text("Instructions")) {
                    Button(action: openInstructionModal) {
                        Label(instructionTitle, systemImage: "plus")
                    }
                    .sheet(isPresented: $showingAddInstructionSheet) {
                        AddInstructionView(recipeInstructions: $recipeInstructions)
                    }
                    InstructionListView(recipeInstructions: $recipeInstructions)
                }
                //Categories
                Section(header: Text("Recipe Category")){
                    MultiSelector(
                        label: Text("Category"),
                        options: viewModel.categories,
                        optionToString: {$0.categoryName},
                        selected: $recipeCategory
                    )
                }
            }
            .navigationTitle(formTitle)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        if let recipe {
                            editRecipe(recipeToEdit: recipe)
                        } else {
                            addRecipe()
                        }
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
        .onAppear {
            if let recipe {
                recipeTitle = recipe.title
                recipeAuthor = recipe.author
                recipeDate = recipe.date
                recipePrepTime = recipe.prepTime
                recipeCookTime = recipe.cookTime
                recipeServings = recipe.servings
                recipeExpertise = recipe.expertise
                recipeCalories = recipe.calories
                recipeIsFavorite = recipe.isFavorite
                recipeCategory = Set(recipe.categories)
                recipeIngredients = recipe.ingredients.sorted(by: { $0.ingredientName < $1.ingredientName })
                recipeInstructions = recipe.instructions.sorted(by: { $0.order < $1.order })
            }
        }
    }
    
    //MARK: - Vars
    private var formTitle: String {
        recipe == nil ? "Add a New Recipe" : "Edit Recipe"
    }
    
    private var ingredientTitle: String {
        recipe == nil ? "Add Ingredients" : "Edit Ingredients"
    }
    
    private var instructionTitle: String {
        recipe == nil ? "Add Instructions" : "Edit Instructions"
    }
    
    //MARK: - Funcs
    private func openIngredientModal() {
        showingAddIngredientSheet.toggle()
    }
    
    private func openInstructionModal() {
        showingAddInstructionSheet.toggle()
    }
    
    private func addRecipe() {
        let newRecipe = Recipe(
            title: recipeTitle,
            author: recipeAuthor,
            date: recipeDate,
            prepTime: recipePrepTime,
            cookTime: recipeCookTime,
            servings: recipeServings,
            expertise: recipeExpertise,
            calories: recipeCalories,
            isFavorite: recipeIsFavorite,
            ingredients: [],
            instructions: [],
            categories: []
        )
        
        recipeCategory.forEach { category in
            recipeCategories.append(category)
        }
        
        newRecipe.categories = recipeCategories
        newRecipe.ingredients = recipeIngredients
        newRecipe.instructions = recipeInstructions
        
        viewModel.addRecipe(newRecipe)
    }
    
    private func editRecipe(recipeToEdit: Recipe) {        
        recipeCategory.forEach { category in
            recipeCategories.append(category)
        }
        
        recipeToEdit.title = recipeTitle
        recipeToEdit.author = recipeAuthor
        recipeToEdit.date = recipeDate
        recipeToEdit.prepTime = recipePrepTime
        recipeToEdit.cookTime = recipeCookTime
        recipeToEdit.servings = recipeServings
        recipeToEdit.expertise = recipeExpertise
        recipeToEdit.calories = recipeCalories
        recipeToEdit.isFavorite = recipeIsFavorite
        recipeToEdit.categories = recipeCategories
        recipeToEdit.ingredients = recipeIngredients
        recipeToEdit.instructions = recipeInstructions
        
        viewModel.saveRecipe()
    }
}

#Preview {
    AddSheetView(recipe: nil)
}
