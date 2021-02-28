//
//  AddStepView.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 2/24/21.
//

import SwiftUI

struct AddStepView: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext

    @EnvironmentObject var recipe: Recipe
    
    //let recipe: Recipe
    let numOfSteps: Int
    
    @State var stepDirections: String = ""
    

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Directions...", text: $stepDirections)

                }
                Section {
                    Button("Save") {
                        addStep()
                        self.presentation.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Step")
        }
        
        
    }
    
    private func addStep() {
        withAnimation {
            let newStep = Step(context: viewContext)
            newStep.directions = stepDirections
            newStep.recipeInput = recipe
            newStep.seqNum = Int16(numOfSteps + 1)

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


/*
struct AddStepView_Previews: PreviewProvider {
    static var previews: some View {
        AddStepView()
    }
}
 */
