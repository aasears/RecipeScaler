//
//  ContentView.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 2/21/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showAddRecipeModal = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.timestamp, ascending: true)],
        animation: .default)
    private var recipes: FetchedResults<Recipe>

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(recipes) { recipe in
                        //Text("Recipe at \(recipe.timestamp!, formatter: recipeFormatter)")
                        //RecipeDetailView(recipe: recipe)
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            HStack {
                                //Image(recipe.recipeIcon ?? "default")
                                Text(recipe.title!)
                            }
                        }
                    }
                    .onDelete(perform: deleteRecipes)
                }
                .listStyle(PlainListStyle())
                
                HStack {
                    Spacer()
                    Button(action: {
                        showAddRecipeModal = true
                    }) {
                        Label("Add Recipe", systemImage: "plus")
                    }
                }
                
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItemGroup() {
                    #if os(iOS)
                    EditButton()
                    #endif
                }
            }
        }
        .sheet(isPresented: $showAddRecipeModal, onDismiss: {
        }) {
            AddRecipeView()
        }
    }
    



    private func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            offsets.map { recipes[$0] }.forEach(viewContext.delete)

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

private let recipeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()



/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
*/

