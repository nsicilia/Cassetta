//
//  BlockListView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/17/23.
//

import SwiftUI

struct BlockListView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    
    var body: some View {
        VStack{
            if viewModel.blockedUsers.count > 0 {
                ScrollView{
                    ForEach(viewModel.blockedUsers, id: \.id) { user in
                        HStack{
                            LargeUserCell(profileImg: user.profileImageURL, username: user.username, fullname: user.fullname)

                            UnblockButtonView(viewModel: viewModel, user: user)
                        }
                    }
                }
            }else {
                Text("No blocked users")
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 20)
                    .foregroundColor(.black)

            }
        }
        .navigationTitle("Unblock Users")
        .onAppear{
            viewModel.getBlockedUsersList()
        }
        .onReceive(viewModel.$userUnblocked) { userUnblocked in
            if userUnblocked {
                viewModel.getBlockedUsersList()
                viewModel.userUnblocked = false
            }
        }
    }//body
    
}


#Preview {
    BlockListView(viewModel: ProfileViewModel(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton")))
}

