//
//  LoginView.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 02/03/2021.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginData = LoginViewModel()
    @State var countryCodesPresented = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Your Phone")
                    .font(.largeTitle)
                    //.fontWeight(.heavy)
                    .padding(.bottom, 20)
                
                Text("Please confirm your country code and enter your phone number.")
            }
            .padding()
            
            //  Country codes sections
            /*HStack {
                Button(action: {
                    countryCodesPresented.toggle()
                }, label: {
                    Text("Country codes")
                })
                Spacer()
            }.padding(.horizontal)*/
            
            // TODO: make `number` field first responder
            // TODO: define automatically locale field by users' Locale property
            // TODO: when identified country, present it in the following format: "🏁 countryName"
            HStack(spacing: 15) {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                    Text("+")
                    TextField("Code", text: $loginData.code).offset(x: 12)
                }
                .padding()
                .keyboardType(.numberPad)
                .frame(width: 75)
                .background(Color.blue.opacity(0.16))
                .cornerRadius(15)

                TextField("Number", text: $loginData.number)
                    .padding()
                    .keyboardType(.numberPad)
                    .background(Color.white.opacity(0.06))
                    .cornerRadius(15)
            }
            .padding()
            .padding(.top, 10)
            
            if loginData.isLoading {
                ProgressView()
                    .padding()
            } else {
                Button(action: loginData.verifyUser, label: {
                    Text("Verify")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color.blue)
                })
                .disabled(loginData.code == "" || loginData.number == "" ? true : false)
                .opacity(loginData.code == "" || loginData.number == "" ? 0.5 : 1)
            }
        }
        
        // Displaying alert...
        .alert(isPresented: $loginData.error, content: {
            Alert(title: Text("Error"), message: Text(loginData.errorMsg), dismissButton: .destructive(Text("Ok")))
        })
        .fullScreenCover(isPresented: $loginData.registerUser, content: {
            RegisterView()
        })
        .sheet(isPresented: $countryCodesPresented, content: {
            // FIXME: fix CountryCallingCodes View
            /*if #available(iOS 15.0, *) {
                CountryCallingCodesView()
            }*/
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

/*
// logging in for email
struct LoginView: View {
    
    @State var isPresented: Bool = false
    @State var isActive: Bool = false
    
    @ObservedObject private var loginVM = LoginViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $loginVM.email)
                .padding(.bottom, 20)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $loginVM.password)
            
            
            Button("Login") {
                loginVM.login {
                    isActive = true
                }
            }
            .buttonStyle(DefaultButtonStyle())
            .padding(.bottom, 10)
            
            Button("Create account") {
                isPresented = true
            }.buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal)
        
        .sheet(isPresented: $isPresented, content: {
            RegisterView()
        })
    }
}
*/
