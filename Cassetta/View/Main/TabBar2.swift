//
//  TabBar2.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/24/22.
//

import SwiftUI

struct TabBar2: View {
    var body: some View {
        NavigationView {
            TabView {
                
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
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                
                UploadPostView()
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                
                
                NotificationsView()
                    .tabItem {
                        Image(systemName: "heart")
                    }
                
                
                UserProfile()
                    .tabItem {
                        Image(systemName: "person")
                    }
                
            }
            .navigationTitle("home")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.black)
        }
        
    }
}

struct TabBar2_Previews: PreviewProvider {
    static var previews: some View {
        TabBar2()
    }
}
