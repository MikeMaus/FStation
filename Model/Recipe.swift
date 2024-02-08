//
//  Recipe.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 13/01/2021.
//  Should I do a struct(i.e.) model for every type of food?! like sandwich, salad, etc... ???

import Foundation
import SwiftUI
// I need to add 'import FirebaseFirestoreSwift' and, then, add '@DocumentID' property wrapper before id variable
// Should I do a struct(i.e.) model for every type of food?! like sandwich, salad, etc... ???

// All the attributes have to conform to the same name of attributes in the Firestore
// Update as this document as it goes

struct Recipe: Identifiable, FeedCommonContent /*, Codable*/ {
    var feedIdentity = FeedIdentity.Recipe
    var id: String // = UUID().uuidString // temporarily, check to change back to this -> `var id: String`
    var titleImage: String //Image (?)
    var name: String
    var author: User
    var ingredients: [String]
    var cookingSteps: [String]
    var notes: String
    var time: Date
    var warnings: String
    var servings: String // var portions: Int // think of making it an Int? , for finding a better name? , think of making it a dictionary [#ofServings : [ingredientsAmount]] ?
    //var pauses = [""]
    
    
    //var mediaRemarksEtc = [Any]()
    //var photos = [Any]()
    
    
    //var likes: Int
    //var specialCookware: [String] = [""]
    //var identifier = ""
    //var rating: Int
    
    
    /*
    // If we want to use different from Firesetore attribute name here, we need to tell it to swift via CodingKeys
    enum CodingKeys: String, CodingKey {
        // provide all the attribute names here
        case id, recipeName, ingredients
        // as example here
        case steps = "CookingSteps"
        case specialCookware = "cookware"
    }
    */
}

struct Product {
    var storageNotes = ""
}
