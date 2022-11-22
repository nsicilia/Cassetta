//
//  UserProfile.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 6/8/22.
//

import SwiftUI

struct UserProfile: View {
    let user: User
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            ProfileHeaderView(user: user)
                .padding(.bottom)
            
            Feed()
            
        }
        .background(Color("CassettaTan"))
        
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton"))
    }
}
