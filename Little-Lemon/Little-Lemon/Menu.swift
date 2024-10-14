//
//  Menu.swift
//  Little-Lemon
//
//  Created by Ksenia Meshch on 10.10.2024.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText: String = ""
    
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
            
            TextField("Search text", text: $searchText)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            Text("\(dish.title ?? "") - \(dish.price ?? "")")
                                .font(.headline)

                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image
                                    .resizable() // Make the image resizable
                                    .scaledToFit() // Maintain aspect ratio
                                    .frame(width: 50, height: 50) // Set the desired size
                            } placeholder: {
                                ProgressView() // Show a loading indicator while the image loads
                            }
                        }
                    }
                }
            }
        } //end of VStack
        .onAppear(){
            getMenuData()
        }
    }
    func getMenuData() {
            PersistenceController.shared.clear()
            let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json" //menu URL
            
            // Create a URL object and force unwrap it (assuming URL is correct)
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            // Step 4: Create a URLRequest instance
            let request = URLRequest(url: url)
            
            // Step 5: Call dataTask on URLSession
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error fetching menu data: \(error)")
                    return
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    if let menuList = try? decoder.decode(MenuList.self, from: data) {
                        //code if decoding is successful
                        let menuItems = menuList.menu //saves decoded menu items
                        
                        //loop through menu items and save as core data
                        for item in menuItems {
                            let dish = Dish(context: self.viewContext)//initializes Dish entity
                            dish.title = item.title
                            dish.image = item.image
                            dish.price = item.price
                            
                            try? self.viewContext.save()
                        }
                    } else {
                        print("failed to decode JSON.")
                    }
                }
            }
            //Start the task
            task.resume()
        }//end of getMenuData
    func buildSortDescriptors() -> [NSSortDescriptor] {
        //used for sorting dishes in natural way
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() ->  NSPredicate {
        //specify conditions (called predicates) to only retrieve objects that match certain criteria
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        else {
            // If search text is not empty, filter dishes where title contains the search text
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
        
}

#Preview {
    Menu()
}
