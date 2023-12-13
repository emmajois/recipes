//
//  AddSheetView.swift
//  recipes
//
//  Created by Emma Swalberg on 12/12/23.
//

import SwiftUI

struct AddSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ViewModel.self) private var viewModel
    
    let recipe: Recipe?
    
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
    //Pass the list of instructions and ingredients list down to the child structs and then they can be referenced here.
    
    init(recipe: Recipe?) {
        self.recipe = recipe
    }
    //if there are issues with the save, try and save manually. modelContext.save.

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
                Section(header: Text("Recipe Category")){
                    MultiSelector(
                        label: Text("Category"),
                        options: viewModel.categories,
                        optionToString: {$0.categoryName},
                        selected: $recipeCategory
                    )
                }
                Section {
                    Button("Submit"){
                        addRecipe()
                    }
                }
            }
            .navigationTitle(formTitle)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        if let recipe {
                            //edit save logic
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
                recipeCategories = recipe.categories
                //this may not work
                recipeCategory = Set(recipe.categories)
            }
        }
    }
    
    private var formTitle: String {
        recipe == nil ? "Add a New Recipe" : "Edit Recipe"
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
        
        viewModel.addRecipe(newRecipe)
    }
}

#Preview {
    AddSheetView(recipe: nil)
}
