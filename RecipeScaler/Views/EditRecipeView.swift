//
//  EditRecipeView.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 2/28/21.
//

import SwiftUI

struct EditRecipeView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var recipe: Recipe
    
    @State var recipeTitle: String = ""
    @State var numberOfServering: Int = 0
    @State var ovenTemp: String = ""
    @State private var isShowPhotoLibrary: Bool = false

    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        Button(action: {
            isShowPhotoLibrary = true
        }) {
            ZStack {
                Image(systemName: "photo")
                    .frame(width: 150, height: 150, alignment: .center)
                    .cornerRadius(75)
                    .overlay(RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 4))
            }
        }
        TextField("\(recipe.title!)", text: $recipeTitle)
        Text("Created on: \(recipe.timestamp!, formatter: dateFormatter)")
        Text("Last Updated: \(recipe.lastUpdated!, formatter: dateFormatter)")
        HStack {
            Text("\(recipe.numServings)")
            Text(" Servings")
        }
        HStack {
            TextField("\(recipe.ovenTemp)", text: $ovenTemp)
                .keyboardType(.numberPad)
            Text(" Oven Temp")
        }
        Text("\(recipe.timeDuration) \(recipe.timeDurationUnits ?? "")")
        Button("Save") {
            updateRecipe()
            self.presentation.wrappedValue.dismiss()
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary)
        }
    }
    
    
    
    func setFieldValues(recipe: Recipe) {
        recipeTitle = recipe.title!
        
    }
    
    func updateRecipe() {
        
        if recipeTitle != "" {
            recipe.title = recipeTitle
            recipe.lastUpdated = Date()
        } else {
            // Do nothing for now
        }
        
        
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

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    //formatter.timeStyle = .medium
    return formatter
}()

/*
struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView()
    }
}
*/
