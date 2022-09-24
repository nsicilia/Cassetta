//
//  ContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/7/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
        UINavigationBar.appearance().barTintColor = UIColor.systemBackground
        
    }
    
    
    var body: some View {
        
        TabView{
            //Home
            NavigationView{
                Feed()
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Image("BlackCassettaLogo")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFill()
                                .frame(height: 40)
                                .foregroundColor(Color("CassettaBlack"))
                                
                        }
                        
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Image(systemName: "envelope")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    
            }
            .tabItem {
                Image(systemName: "house")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .padding(.top, 10)
            }
            
            
            
            //Search
            NavigationView{
                SearchView()
                    .navigationTitle("Search")
                    .navigationBarTitleDisplayMode(.inline)
                    .accentColor(.black)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
            }
            
            
            //Upload
            NavigationView{
                UploadPostView()
            }
            .tabItem {
                Image(systemName: "plus")
            }
            
            
            //Notification
            NavigationView{
                NotificationsView()
                    .navigationTitle("Notifications")
                    .navigationBarTitleDisplayMode(.inline)
                    .accentColor(.black)
            }
            .tabItem {
                Image(systemName: "heart")
                    .cornerRadius(12.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 8)
            }
            
            
            //Profile
            NavigationView{
                UserProfile()
                    .toolbar {
                        Label("More Settings", systemImage: "ellipsis")
                    }
            }
            .tabItem {
                Image(systemName: "person")
            }
            
            
            
        }
        .accentColor(Color("CassettaOrange"))
        
        
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
    }
}
