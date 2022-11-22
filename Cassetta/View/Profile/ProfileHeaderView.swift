//
//  ProfileHeaderView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .center){
            
            //Image
            VStack {
                KFImage(URL(string: user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding()
                
                HStack(spacing: 8){
                    //Stats
                    UserStatView(value: 15, title: "Posts")
                    UserStatView(value: 34, title: "Followers")
                    UserStatView(value: 64, title: "Following")
                }
                .padding(.trailing, 16)
            }
            
            //name
            Text(user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding(.top)
            
            //description
            Text("OH ✈️ NY ✈️ CA   |   ASU '19   |   fashion, travel & lifestyle")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 32)
                .padding(.top, 1)
            
            
            VStack {
                //Buttons
                ProfileActionButtonView(isCurrentUser: user.isCurrentUser)

            }
            .padding(.top, 42)
            .padding(.bottom)
            
        }
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
            ProfileHeaderView(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton"))
        }
    }
}
