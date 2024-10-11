//
//  Onboarding.swift
//  Little-Lemon
//
//  Created by Ksenia Meshch on 10.10.2024.
//
// Global String constants
let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmail = "emailKey"
let kIsLoggedIn = "kIsLoggedIn" //used to check if user entered everything to start navigation


import SwiftUI

struct Onboarding: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var isLoggedIn: Bool = false //used to navigate to home
    
    
    var body: some View {
        NavigationStack{
            VStack {
                TextField("First name",text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Email", text: $email)
                
                Button(action: {
                    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
                        print("Please fill in all fields")
                    }
                    else {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)//the next time the app is launched, the value of kIsLoggedIn can be checked to determine whether to show the onboarding page again or not
                        isLoggedIn = true
                    }
                }, label: {
                    Text("Register")
                })
            }//end of Vstack
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }//navigates to home if a user is logged in
            .onAppear(){
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }//checks if a user oppened an app for the first time or not
        
            }
        }
        
    }
}

#Preview {
    Onboarding()
}
