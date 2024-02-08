//
//  HomeView.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 02/04/2021.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("current_status") var status = false
    @State var selectedTab: String = "Posts" // check it if it should be accessible to other screens, private/ not private
    ///This is very important to initialize `PersistenceController` before using it. So that the entities are loaded.
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        //NavigationView {
        TabView {
            NavigationView {
            FeedView()
                .navigationBarHidden(true)
                .navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
            }//.navigationBarTitle("Huyaaa").navigationBarHidden(true).navigationBarTitleDisplayMode(.inline)
                .tabItem {
                    Label("Posts", systemImage: "newspaper")
                }
//                .onTapGesture {
//                    selectedTab = "Posts"
//                    print(selectedTab)
//                }
                .ignoresSafeArea(.all, edges: .top)
            
            CDataListView()//ShoppingListView()
                // Persistence initializer
                .tabItem {
                    Label("Groceries", systemImage: "cart")
                } 
                .ignoresSafeArea(.all, edges: .top)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "person.crop.circle")
                }
                .onTapGesture {
                    selectedTab = "Settings"
                    print(selectedTab)
                }
                .ignoresSafeArea(.all, edges: .top)
        }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        //} // <- Top NavigationView
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
