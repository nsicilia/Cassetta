//
//  UserListView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/14/22.
//

import SwiftUI
//import Firebase

struct UserListView: View {
    
    @StateObject var viewModel: SearchViewModel
    @Binding var searchText: String
    
    //For the LNPopup & Playerview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    
    //Test
    @StateObject var postViewModel: PostViewModel
        
    var users: [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)
    }
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(users) { user in
                    
                    NavigationLink {
                        ProfileView(user: user, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
                        
                    } label: {
                        LargeUserCell(user: user)
                            .padding(.leading)
                    }

                    
                }
            }
        }
    }
}
//
//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView(viewModel: SearchViewModel(), searchText: .constant("Search"), isPopupBarPresented: .constant(false), PlayingPost: .constant(Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!")))
//    }
//}
