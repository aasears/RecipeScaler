//
//  AddRecipeView.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 2/22/21.
//

import SwiftUI
import CoreData

struct AddRecipeView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.timestamp, ascending: true)],
        animation: .default)
    
    private var recipes: FetchedResults<Recipe>
    
    @State var recipeTitle: String = ""
        
    var body: some View {
        NavigationView {
            Form {
                TextField("Recipe Title...", text: $recipeTitle)
                Button("Save") {
                    if recipeTitle.isEmpty {
                        
                    } else {
                        addRecipe(recipeTitle: recipeTitle)
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                Button("Cancel") {
                    self.presentation.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("Add New Recipe")
            
        }
                
    }


    private func addRecipe(recipeTitle: String) {
        withAnimation {
            let newRecipe = Recipe(context: viewContext)
            newRecipe.timestamp = Date()
            newRecipe.lastUpdated = Date()
            newRecipe.title = recipeTitle

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
