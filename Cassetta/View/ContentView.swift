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
                                Text("Cassetta")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(Color(UIColor.systemGray))
                                    
                            }
                        }
                        
                }
                .tabItem {
                    Image(systemName: "house")
                }
                
                
                //Search
                NavigationView{
                SearchView()
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
                
                //Upload
                NavigationView{
                NotificationsView()
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

        
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
