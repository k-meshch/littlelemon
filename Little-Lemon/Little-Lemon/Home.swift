//
//  Home.swift
//  Little-Lemon
//
//  Created by Ksenia Meshch on 10.10.2024.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView{
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            // New Profile tab
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true) // Hide the back button
    }
}

#Preview {
    Home()
}
