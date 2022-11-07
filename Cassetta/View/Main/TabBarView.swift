//
//  TabBarView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI

struct TabBarView: View {
    
    init(){
        //Make the navigation bar trasparent
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        //Make the TabBar white and not trasparent
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().isTranslucent = true
//        UITabBar.appearance().backgroundColor = .white
        
        //Makes unselected icons black
        UITabBar.appearance().unselectedItemTintColor = .black

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
                            Image("MessageImage")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                        }
                    }
                    
                    .background(Color("CassettaTan"))
                    
            }
            .tabItem {
                Image("HomeImage")
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
                Image("SearchImage")
                    
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
                        //Label("More Settings", systemImage: "ellipsis")
                        
                        Menu {
                            Text("hat")
                            Text("cat")
                            Text("bat")
                        } label: {
                            Label("More Settings", systemImage: "ellipsis")
                        }
                    }
            }
            .tabItem {
                Image(systemName: "person")
            }
            
            
            
        }
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
