//
//  Menu.swift
//  Little-Lemon
//
//  Created by Ksenia Meshch on 10.10.2024.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little Lemon")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)//moves text slightly right

            Text("Chicago")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)//moves text slightly right
            Text("Welcome to our restaurant app, where you can browse the menu and place orders.")
                .font(.body)
                .padding(10)
            
            List {
                    // Empty for now, you will add menu items here later
                }
        }
    }
}

#Preview {
    Menu()
}
