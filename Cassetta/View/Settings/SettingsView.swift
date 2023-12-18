//
//  SettingsView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/17/23.
//

import SwiftUI

struct SettingsView: View {
    
    var authView: AuthViewModel
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    
    init(authView: AuthViewModel, user: User) {
        self.user = user
        self.authView = authView
        self.viewModel = ProfileViewModel(user: user)
    }
    
        
    var body: some View {
        VStack {
            List {
                NavigationLink{ BlockListView(viewModel: viewModel)
                    } label: {
                    Text("Unblock")
                }
                
                
                Section(header: Text("Login")) {
                    Button {
                        authView.signout()
                    } label: {
                        Text("Sign Out")
                    }
                }
                
            }
            //.listStyle(GroupedListStyle()) // Use GroupedListStyle for the background color to cover the entire list area
            .background(Color("CassettaTan"))
            .scrollContentBackground(.hidden)
            .navigationTitle("Settings")
            
        }
        
    }
}



#Preview {
    SettingsView(authView: AuthViewModel(), user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton"))
    .environmentObject(AuthViewModel())
}
