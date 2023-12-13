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
    
    @State var recipeTitle: String = ""
    @State var recipeAuthor: String = ""
    @State var recipeDate: Date = Date()
    @State var recipePrepTime = 5
    @State var recipeCookTime: Int = 5
    @State var recipeServings: Int = 1
    @State var recipeExpertise: Int = 1
    @State var recipeCalories: Int = 5
    @State var recipeIsFavorite: Bool = false
    @State var recipeCategory: String = "Appetizer"
    @State var recipeCategories: [RecipeCategory] = []
    //Pass the list of instructions and ingredients list down to the child structs and then they can be referenced here.
    
    //have an init, if there is a recipe that has been passed, assign them to the state vars for edit
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
                //TODO: Make it so multiple categories can be added
                //TODO: Make it so it can actually add the category
                Section(header: Text("Recipe Category")){
                    Picker("Category", selection: $recipeCategory){
                        ForEach(viewModel.categories) {category in
                            Text(category.categoryName).tag(category.categoryName)
                        }
                    }
                }
                Section {
                    Button("Submit"){
                        addRecipe()
                    }
                }
            }
            .navigationTitle("Add Recipe")
            .toolbar {
                ToolbarItem{
                    Button("", systemImage: "xmark.circle") {
                        dismiss()
                    }
                }
            }
        }
    }
    
//        private var formTitle: String {
//            recipe == nil? "New Recipe" : "Edit Recipe"
//        }
    
    private func addRecipe() {
        //search all the categories where it matches the string and then append that category on there
        //recipeCategories.append(viewModel.findCategory(categoryString: recipeCategory))
        
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
        
        recipeCategories.append(viewModel.findCategory(categoryString: recipeCategory))
        
        newRecipe.categories = recipeCategories
        
        viewModel.addRecipe(newRecipe)
        
        dismiss()
    }
}

#Preview {
    AddSheetView()
}
