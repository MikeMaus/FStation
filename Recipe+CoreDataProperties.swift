//
//  CoreDataRecipe+CoreDataProperties.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 26/07/2021.
//
//

import Foundation
import CoreData


extension CoreDataRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRecipe> {
        return NSFetchRequest<CoreDataRecipe>(entityName: "CoreDataRecipe")
    }

    
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var completed: Bool
    @NSManaged public var recipeIngredient: NSSet?
    
    public var ingredientsArray: [ShoppingItem] {
        let set = recipeIngredient as? Set<ShoppingItem> ?? []
        
        return set.sorted {
            // FIXME: setup sorting properly!!
            $0.timestamp ?? Date().addingTimeInterval(10) < $1.timestamp ?? Date() //TODO: setup sorting here!!!
        }
    }
}

extension CoreDataRecipe : Identifiable {

}









// ☇↓↘︎ don't think I'd need that
// MARK: Generated accessors for recipeIngredient
extension CoreDataRecipe {

    @objc(addRecipeIngredientObject:)
    @NSManaged public func addToRecipeIngredient(_ value: ShoppingItem)

    @objc(removeRecipeIngredientObject:)
    @NSManaged public func removeFromRecipeIngredient(_ value: ShoppingItem)

    @objc(addRecipeIngredient:)
    @NSManaged public func addToRecipeIngredient(_ values: NSSet)

    @objc(removeRecipeIngredient:)
    @NSManaged public func removeFromRecipeIngredient(_ values: NSSet)

}

