//
//  RecipeScalerApp.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 2/21/21.
//

import SwiftUI

@main
struct RecipeScalerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
