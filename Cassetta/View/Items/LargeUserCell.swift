//
//  LargeUserCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/19/22.
//

import SwiftUI
import Kingfisher

struct LargeUserCell: View {
   // let user: User
    
    let profileImg: String
    let username: String
    let fullname: String
    
    var body: some View {
        HStack{
            
            //Image
            KFImage(URL(string: profileImg))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            //username, fullname
            VStack(alignment: .leading){
                Text(username)
                    .font(.system(size: 14, weight: .semibold))
                
                Text(fullname)
                    .font(.system(size: 14))
            }
            Spacer()
        }
    }
}

struct LargeUserCell_Previews: PreviewProvider {
    static var user = User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton")
    
    static var previews: some View {
        LargeUserCell(profileImg: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", username: "username", fullname: "Full Name")
    }
}
