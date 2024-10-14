//
//  Home.swift
//  Little-Lemon
//
//  Created by Ksenia Meshch on 10.10.2024.
//

import SwiftUI

struct Home: View {
    //The Home screen will initialize the Core Data and pass its view context to the Menu instance on initialization.

    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView{
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .environment(\.managedObjectContext, persistence.container.viewContext)
            // New Profile tab
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .accentColor(.green)
        .navigationBarBackButtonHidden(true) // Hide the back button
    }
    
}

#Preview {
    Home()
}
