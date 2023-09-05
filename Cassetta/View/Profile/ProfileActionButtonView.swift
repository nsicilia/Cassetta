//
//  ProfileActionButtonView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel
    var isFollowed: Bool { return viewModel.user.isFollowed ?? false}
    @State var showEditProfile = false
    
    var body: some View {
        
        if viewModel.user.isCurrentUser {
            //user profile edit button
            Button {
                showEditProfile = true
            } label: {
                Text("Edit Profile")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 300, height: 32)
                    .foregroundColor(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    }
            }.sheet(isPresented: $showEditProfile) {
                EditProfileView(user: $viewModel.user)
            }
        }else {
            //Follow button and message button
            HStack{
                
                //Follow/Unfollow button
                Button {
                    //if is followed returns true -> unfollow function
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                    
                } label: {
                    Text(isFollowed ? "Following": "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 150, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? .white : Color("CassettaOrange"))
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        }
                }

                
                //Message button
                Button {
                    //todo
                } label: {
                    Text("Message")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 150, height: 32)
                        .foregroundColor(Color("CassettaBlack"))
                        .background(Color("CassettaWhite"))
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                }
                
            }
            
        }
            
    }
}



struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView(viewModel: ProfileViewModel(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton")))
    }
}
