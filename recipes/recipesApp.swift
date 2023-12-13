//
//  recipesApp.swift
//  recipes
//
//  Created by Emma Swalberg on 11/21/23.
//
// Recipe Icon courtsey of AdobeStock

import SwiftUI
import SwiftData

@main
struct recipesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Recipe.self, RecipeCategory.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RecipeView(sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
