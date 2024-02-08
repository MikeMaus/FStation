//
//  LoginViewModel.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 31/03/2021.
//

import Foundation
import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    
    @Published var code = ""
    @Published var number = ""
    
    //For any errors...
    @Published var errorMsg = ""
    @Published var error = false
    
    @Published var registerUser = false
    @AppStorage("current_status") var status = false
    
    // Loading when Searches for user...
    @Published var isLoading = false
    
    func verifyUser() {
        
        isLoading = true
        
        // Remove when TEsting in live !!!!!!!!!!!!
        //Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let phoneNumber = "+" + code + number
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (ID, err) in
            if err != nil {
                self.errorMsg = err!.localizedDescription
                self.error.toggle()
                self.isLoading = false
                return
            }
            
            // Code Sent Successfully...
            
            alertView(msg: "Enter Verification Code") { (Code) in
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: ID!, verificationCode: Code)
                
                Auth.auth().signIn(with: credential) { (res, err) in
                    if err != nil {
                        self.errorMsg = err!.localizedDescription
                        self.error.toggle()
                        self.isLoading = false
                        return
                    }
                    
                    self.checkUser()
                }
            }
            /// It can be deleted, but previously there was a method alertView that enabled alert view for verification
            /// Notes: - and I would prefer to go back as it was, to separate it from the whole app logic, and leave only for login screen process
//            self.alertView { (Code) in
//                let credential = PhoneAuthProvider.provider().credential(withVerificationID: ID!, verificationCode: Code)
//
//                Auth.auth().signIn(with: credential) { (res, err) in
//                    if err != nil {
//                        self.errorMsg = err!.localizedDescription
//                        self.error.toggle()
//                        self.isLoading = false
//                        return
//                    }
//
//                    self.checkUser()
//                }
//            }
        }
    }
    
    
    func checkUser() {
        let ref = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        ref.collection("Users").whereField("uid", isEqualTo: uid).getDocuments { (snap, err) in
            if err != nil {
                // No Documents..
                // No User Found...
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            
            if snap!.documents.isEmpty {
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            self.status = true
        }
    }
}

/* Login with Email
class LoginViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    
    func login(completion: @escaping () -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("logged in successfully")
                completion()
            }
        }
    }
}
*/
