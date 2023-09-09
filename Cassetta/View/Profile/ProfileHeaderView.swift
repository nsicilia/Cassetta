//
//  ProfileHeaderView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            
            //Image
            VStack {
                KFImage(viewModel.userSessionProfilePhoto)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding()
                
                HStack(spacing: 8){
                    //Stats
                    UserStatView(value: viewModel.user.stats?.posts ?? 0, title: "Posts")
                    UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
                    UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Following")
                }
                .padding(.trailing, 16)
            }
                        
            //name
            Text(viewModel.user.fullname)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top)
                .padding(.bottom, 0.5)
            
            Text("@\(viewModel.user.username)")
                .font(.system(size: 14))
                .padding(.bottom, 26)
            
            
            //description
            if let bio = viewModel.user.bio {
                
                Text(bio)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 32)
                    .padding(.top, 1)
                    .lineLimit(3)
                
            } else {
                Text("Bio")
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 32)
                    .padding(.top, 1)
                    .lineLimit(4)
            }
            
            
            VStack {
                //Buttons
                ProfileActionButtonView(viewModel: viewModel)
            }
            .padding(.top, 42)
            .padding(.bottom)
            
        }
        .frame(width: UIScreen.main.bounds.width - 32)
        .background(.white)
        .cornerRadius(15.0)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(UIColor.secondaryLabel), lineWidth: 0.5)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("CassettaTan").edgesIgnoringSafeArea(.all)
            ProfileHeaderView(viewModel: ProfileViewModel(user: User(username: "jessicadoeinton", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jessica Doeinton")))
        }
    }
}
