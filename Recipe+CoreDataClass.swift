//
//  CoreDataRecipe+CoreDataClass.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 26/07/2021.
//
//

import Foundation
import CoreData

@objc(CoreDataRecipe)
public class CoreDataRecipe: NSManagedObject {

    static func getAllRecipes() -> NSFetchRequest<CoreDataRecipe> {
        let request: NSFetchRequest<CoreDataRecipe> = CoreDataRecipe.fetchRequest() //as! NSFetchRequest<ShoppingItem>
        
        // let sortDescriptor = NSSortDescriptor(key: "completed", ascending: false)
        let dateSortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true)
        
        request.sortDescriptors = [dateSortDescriptor]

        return request
    }
    
    
}
