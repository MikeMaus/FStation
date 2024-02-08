//
//  FetchUSer.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 23/04/2021.
//

import Foundation
import Firebase

// Global reference

let db = Firestore.firestore()

func fetchUser(uid: String, completion: @escaping (User) -> () ) {
    
    db.collection("Users").document(uid).getDocument { (doc, err) in
        guard let user = doc else { return }
        
        // TODO: if there's no certain field in the database document, from the list above, an app will throw an error;  (as you see it's forced typecasting `as!`)
        let username = user.data()?["username"] as! String
        let pic = user.data()?["imageurl"] as! String
        let bio = user.data()?["bio"] as! String
        let uid = user.documentID
        // let bio = user.data()?["bio"] as! String       <- previous format for all
        
        DispatchQueue.main.async {
            completion(User(userName: username, pic: pic, bio: bio, uid: uid))
        }
    }
}
