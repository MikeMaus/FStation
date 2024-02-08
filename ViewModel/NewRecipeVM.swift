//
//  NewRecipeVM.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 21/07/2021.
//  TODO: think where it's best to apply decomposition, at what stage

import SwiftUI
import Firebase

class NewRecipeViewModel: ObservableObject {
    
    @Published var recipeName = ""
    @Published var notes = ""     // <- ?
    @Published var ingredients = ""
    @Published var cookingSteps = ""
    @Published var warnings = ""
    
    @Published var selectedServingsIndex: Int?
    var dataForServingsPicker: [String] {
        var array = [""] // first element in array
        for number in 1..<101 {
            array.append("\(number)")
        }
        return array
    }

    /// Image Picker state indicator
    @Published var picker = false
    @Published var img_Data = Data(count: 0)

    
    // disabling all controls while posting...
    @Published var isPosting = false
    
    let uid = Auth.auth().currentUser!.uid
    
    // DECOMPOSED variables
    @Published var ingredientsDecomposed = [String]()
    @Published var cookingStepsDecomposed = [String]()
    
    /// Transforming recipe into format that would be stored in database
    func applyDecomposition() {
        ingredientsDecomposed = decompose(ingredients: ingredients)
        cookingStepsDecomposed = decompose(cookingSteps: cookingSteps)
    }
    
    func post(updateId: String, present: Binding<PresentationMode>) {
        
        applyDecomposition()
        
        // posting Data...
        isPosting = true
        
        if updateId != "" { // what is fucking `updateId`; is it just postId ?
            // Updating Data...
            db.collection("Recipes").document(updateId).updateData([
                "recipeName": self.recipeName,
                "recipeNotes": self.notes,
                "ingredients": self.ingredientsDecomposed, //self.ingredients,
                "cookingSteps": self.cookingStepsDecomposed, //self.cookingSteps,
                "warnings": self.warnings
                // "url": // TODO: check on updating ImageURL
                // TODO: add update time?
                
            ]) { (err) in
                self.isPosting = false
                if err != nil {return}
                
                present.wrappedValue.dismiss()
            }
            
            return
        }
        
        if img_Data.count == 0 {
            db.collection("Recipes").document().setData([
                "recipeName": self.recipeName,
                "recipeNotes": self.notes,
                "servings": self.dataForServingsPicker[selectedServingsIndex ?? 0], // if index is not specified (i.e. user haven't typed in servings), the choice will be index 0, which is empty string in `dataForServingsPicker` array
                "ingredients": self.ingredientsDecomposed, //self.ingredients,
                "cookingSteps": self.cookingStepsDecomposed, //self.cookingSteps,
                "warnings": self.warnings,
                "url": "",
                "uid": self.uid, // <- user ID
                "ref": db.collection("Users").document(self.uid),
                "time": Date()
                
            ]) { (err) in
                if err != nil {
                    self.isPosting = false
                    return
                }
                
                self.isPosting = false
                // closing View When Successfully Posted...
                present.wrappedValue.dismiss()
            }
        } else {
            
            UploadImage(imageData: img_Data, path: "post_Pics") { (url) in
                db.collection("Recipes").document().setData([
                    "recipeName": self.recipeName,
                    "recipeNotes": self.notes,
                    "servings": self.dataForServingsPicker[self.selectedServingsIndex ?? 0], // if index is not specified (i.e. user haven't typed in servings), the choice will be index 0, which is empty string in `dataForServingsPicker` array
                    "ingredients": self.ingredientsDecomposed, //self.ingredients,
                    "cookingSteps": self.cookingStepsDecomposed, //self.cookingSteps,
                    "warnings": self.warnings,
                    "url": url,                                                     // change to "img_url" (?)
                    "uid": self.uid, // <- user ID
                    "ref": db.collection("Users").document(self.uid),
                    "time": Date()                                                  // to add "updateTime", too (?)
                    
                    
                ]) { (err) in
                    if err != nil {
                        self.isPosting = false
                        return
                    }
                    
                    self.isPosting = false
                    // closing View When Successfully Posted...
                    present.wrappedValue.dismiss()
                }
            }
        }
    }
}
