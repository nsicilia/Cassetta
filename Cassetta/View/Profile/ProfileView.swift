//
//  UserProfile.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 6/8/22.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var feedModel: FeedViewModel
    
    //For the LNPopup & Playerview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    //@Binding var PlayingPost: Post?
    
    //test
    @ObservedObject var postViewModel: PostViewModel
    
    
    init(user: User, isPopupBarPresented: Binding<Bool>, isPopupOpen: Binding<Bool>, postViewModel: PostViewModel) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
        self._isPopupBarPresented = isPopupBarPresented
        self._isPopupOpen = isPopupOpen
        
        // Assign the instance of `PostViewModel` passed as parameter to the variable `postViewModel`.
        self.postViewModel = postViewModel
        
        // Initialize `feedModel` after checking for `user.id`.
        if let userId = user.id {
            self.feedModel = FeedViewModel(config: .profile(userId))
        } else {
            // If `user.id` is nil, initialize `feedModel` with an empty `FeedConfig`.
            self.feedModel = FeedViewModel(config: .profile(user.id ?? ""))
        }
    }

    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            ProfileHeaderView(viewModel: viewModel)
                .padding(.bottom)
            
           // Feed(viewModel: FeedViewModel())
            Feed(viewModel: feedModel, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
            
        }
        .background(Color("CassettaTan"))
        
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton"), isPopupBarPresented: .constant(false), isPopupOpen: .constant(true), postViewModel: PostViewModel())
    }
}
