//
//  UserProfile.swift
//  Little-Lemon
//
//  Created by Ksenia Meshch on 10.10.2024.
//

import SwiftUI

struct UserProfile: View {
    // Step 2: Create constants to hold user data
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: kEmail) ?? "" // ?? "" is a nil-coalescing operator that provides a default value when an optional is nil. It means, "if the value on the left side is nil, use the value on the right side instead
    
    @Environment(\.presentationMode) var presentation //the state of whether the current view is being shown or needs to be dismissed (closed)
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
                .resizable()// Make the image resizable
                .scaledToFit()
                .frame(width: 100, height: 100) // Set size for the image
            
            Text("First Name: \(firstName)")
            Text("Last Name: \(lastName)")
            Text("Email: \(email)")
            Button (action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Log out")
            })
            Spacer()//moves everything to the top 
            
        }
        .padding() // Optional: Add padding around the VStack
    }
}

#Preview {
    UserProfile()
}
