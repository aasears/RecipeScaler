//
//  AddIngredientView.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 2/22/21.
//

import SwiftUI

struct AddIngredientView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var recipe: Recipe
    
    //let recipe: Recipe
    let numOfIng: Int
    
    @State var ingredientQuantity: Int = 0
    @State var partialIngQty: String = ""
    @State var ingredientTitle: String = ""
    @State private var ingredientUnits = "c"
    

        
    var body: some View {
        VStack {
            Text("Add New Ingredient")
            HStack {
                Spacer()
                Picker("Quantity", selection: $ingredientQuantity) {
                    ForEach(0..<1000) { qty in
                        Text("\(qty)")
                    }
                }
                .frame(width: 50)
                .clipped()
                Spacer()
                Picker("PartialQuantity", selection: $partialIngQty) {
                    ForEach(PartialQuantity.allCases) { qty in
                        Text(qty.rawValue)
                    }
                }
                .frame(width: 50)
                .clipped()
                Spacer()
                Picker("Unit", selection: $ingredientUnits) {
                    ForEach(Unit.allCases) { unit in
                        Text(unit.rawValue)
                    }
                }
                .frame(width: 50)
                .clipped()
                Spacer()
            }

            //TextField("Units...", text: $ingredientUnits)
            TextField("Ingredient Name...", text: $ingredientTitle)

            Button("Save") {
                addIngredient()
                self.presentation.wrappedValue.dismiss()
            }

        }
        
    }
    
    private func addIngredient() {
        withAnimation {
            let newIngredient = Ingredient(context: viewContext)
            newIngredient.title = ingredientTitle
            //newIngredient.quantity = Double(ingredientQuantity) ?? 0
            newIngredient.unit = ingredientUnits
            newIngredient.displayQty = String(ingredientQuantity)
            newIngredient.displayPartQty = partialIngQty
            newIngredient.recipeInput = recipe
            newIngredient.seqNum = Int16(numOfIng + 1)
            
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

/*
struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView()
    }
}
 */
