//
//  RecipeDetailView.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 2/22/21.
//

import SwiftUI
import CoreData

enum ActiveSheet {
   case ingredient, step, recipeDetails
}

struct RecipeDetailView: View {
    
    @State private var showAddModal = false
    @State private var activeSheet: ActiveSheet = .ingredient
    
    @Environment(\.managedObjectContext) private var viewContext

    /*
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ingredient.id, ascending: true)],
        predicate: NSPredicate(format: "ingredientInput == %@", selectedRecipe),
        animation: .default)
 */
    
    var ingredientsRequest: FetchRequest<Ingredient>
    var stepRequest: FetchRequest<Step>
    private var ingredients: FetchedResults<Ingredient>{ingredientsRequest.wrappedValue}
    private var steps: FetchedResults<Step>{stepRequest.wrappedValue}
    
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.ingredientsRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Ingredient.seqNum, ascending: true)],
                                               predicate: NSPredicate(format: "recipeInput == %@", recipe),
                                               animation: .default)
        self.stepRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Step.seqNum, ascending: true)],
                                       predicate: NSPredicate(format: "recipeInput == %@", recipe),
                                       animation: .default)
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Last Updated: \(recipe.timestamp!, formatter: dateFormatter)")
                    Spacer()
                    Button("Update Details") {
                        activeSheet = .recipeDetails
                        showAddModal = true
                    }
                }
                List {
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            //Image(recipe.recipeIcon ?? "default")
                            Text(formatQuantity(qty: ingredient.displayQty!, partialQty: ingredient.displayPartQty!))
                            Text("\(ingredient.unit!)")
                            Text("\(ingredient.title!)")

                        }
                    }
                    .onDelete(perform: deleteIngredient)
                    .onMove(perform: moveIngs)
                }
                .listStyle(PlainListStyle())
                .navigationTitle(recipe.title!)
                .toolbar {
                    ToolbarItemGroup() {
                        #if os(iOS)
                        EditButton()
                        #endif
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        activeSheet = .ingredient
                        showAddModal = true
                    }) {
                        Label("Add Ingredient", systemImage: "plus")
                    }
                }
                List {
                    ForEach(steps, id: \.self) { step in
                        HStack {
                            Text("\(step.seqNum). ")
                            Text("\(step.directions!)")

                        }
                    }
                    .onDelete(perform: deleteIngredient)
                    .onMove(perform: moveSteps)
                }
                .listStyle(PlainListStyle())
                
                HStack {
                    Spacer()
                    Button(action: {
                        activeSheet = .step
                        showAddModal = true
                    }) {
                        Label("Add Step", systemImage: "plus")
                    }
                }
                Spacer()
            }
            
        }
        .environmentObject(recipe)
        .sheet(isPresented: $showAddModal, onDismiss: {
        }) {
            if activeSheet == .ingredient {
                AddIngredientView(recipe: recipe, numOfIng: ingredients.count)
            } else if activeSheet == .step {
                AddStepView(recipe: recipe, numOfSteps: steps.count)
            } else if activeSheet == .recipeDetails {
                EditRecipeView(recipe: recipe)
            }
            
        }
    }

    
    
    private func deleteIngredient(offsets: IndexSet) {
        withAnimation {
            offsets.map { ingredients[$0] }.forEach(viewContext.delete)

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
    
    private func formatQuantity(qty: String, partialQty: String) -> String {
        var quantity = String()
        if qty != "0" && partialQty != "" {
            quantity = qty + "-" + partialQty
        } else if qty != "0" && partialQty == "" {
            quantity = qty
        } else if qty == "0" && partialQty != "" {
            quantity = partialQty
        } else {
            quantity = ""
        }
        return quantity
    }
    
    func moveSteps(from source: IndexSet, to destination: Int) {
        
        var revisedList: [Step] = steps.map{ $0 }
        
        revisedList.move(fromOffsets: source, toOffset: destination)
        
        for reverseIndex in stride(from: revisedList.count - 1, through: 0, by: -1) {
            revisedList[reverseIndex].seqNum = Int16(reverseIndex + 1)
        }
    }
    
    func moveIngs(from source: IndexSet, to destination: Int) {
        
        var revisedList: [Ingredient] = ingredients.map{ $0 }

        revisedList.move(fromOffsets: source, toOffset: destination)
        
        for reverseIndex in stride(from: revisedList.count - 1, through: 0, by: -1) {
            revisedList[reverseIndex].seqNum = Int16(reverseIndex)
        }
    }
    
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    //formatter.timeStyle = .medium
    return formatter
}()



/*
struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}
 */

