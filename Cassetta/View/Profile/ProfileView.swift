//
//  UserProfile.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 6/8/22.
//

import SwiftUI
import Firebase
import Kingfisher

struct ProfileView: View {
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var feedModel: FeedViewModel
    
    //For the LNPopup & Playerview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    
    @State var confirmBlock = true
    
    @State var showSheet = false
    @State var blockSheet = false
    @State var reportSheet = false
    
    //Universal Post Object
    @ObservedObject var postViewModel: PostViewModel
    
    @State private var isFullScreenCoverPresented = true
    var isBlocked: Bool { return viewModel.user.isBlocked ?? false}
    
    
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
        ZStack{
            
            ZStack{
                
                ScrollView(showsIndicators: false){
                    ProfileHeaderView(viewModel: viewModel, showSheet: $showSheet, blockSheet: $blockSheet, reportSheet: $reportSheet)
                        .padding(.bottom)
                    
                    Feed(feedviewModel: feedModel, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, theUser: viewModel.user.isCurrentUser, postViewModel: postViewModel)
                }
            }
            //BlockSheet
            .sheet(isPresented: $blockSheet, onDismiss: {
                showSheet = false
                blockSheet = false
            }) {
                BlockSheet(viewModel: viewModel, blockSheet: $blockSheet)
            }
            .sheet(isPresented: $reportSheet, onDismiss: {
                showSheet = false
                reportSheet = false
            }) {
                ReportView(viewModel: viewModel, reportSheet: $reportSheet)
            }
            
            let _ = print("isFullScreenCoverPresented: \(isFullScreenCoverPresented)")
            let _ = print("viewModel.user.isBlocked: \(viewModel.user.isBlocked)")
            
            //Fullscreencover
            if (isFullScreenCoverPresented && (isBlocked) ){
            ZStack {
                Color.gray // Background color, you can change this as needed
                VStack{
                    //Icon
                    Image(systemName: "lock.slash.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(.top, 46)
                    
                    
                    Text("You have Blocked this profile.")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 10)
                    
                    Text("You will no longer see their content.")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                    
                    
                    Text("You can unblock this profile in settings.")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    Divider()
                        .frame(width: UIScreen.screenWidth / 1.1, height: 1)
                        .background(Color("CassettaTan"))
                        .padding(.top, 40)
                    
                    Button(action: {
                        //Show
                        isFullScreenCoverPresented.toggle()
                    }, label: {
                        Text("Show Profile")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .bold))
                            .padding(.top, 40)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 50)
                            //.background(Color("Casse"))
                            .cornerRadius(10)
                    })
                }
            }
        }
            
            
            
        }//ZStack
        .background(Color("CassettaTan"))
        
    }
}

struct UserProfile_Previews: PreviewProvider {
    
    static var post = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        ProfileView(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton"), isPopupBarPresented: .constant(false), isPopupOpen: .constant(true), postViewModel: PostViewModel(post: post))
    }
}
