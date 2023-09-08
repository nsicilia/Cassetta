//
//  NotificationCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/15/22.
//

import SwiftUI
import Kingfisher
import Firebase

struct NotificationCell: View {
    @State private var showPostImage = true
   // let notification: Notification
    @ObservedObject var viewModel: NotificationCellViewModel
    
    //For the LNPopup & Playerview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    
    //Universal Post Object
    @ObservedObject var postViewModel: PostViewModel
   
   var isFollowed: Bool {return viewModel.notification.isFollowed ?? false }
   
   init(viewModel: NotificationCellViewModel, isPopupBarPresented: Binding<Bool>, isPopupOpen: Binding<Bool>, postViewModel: PostViewModel){
       self.viewModel = viewModel
         self._isPopupBarPresented = isPopupBarPresented
            self._isPopupOpen = isPopupOpen
            self.postViewModel = postViewModel
   }
    
    
    
    var body: some View {
        HStack {
            if let user = viewModel.notification.user {
                NavigationLink {
                    ProfileView(user: user, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
                    
                } label: {
            //Image
            KFImage(URL(string: viewModel.notification.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            //Name + Notifiaction
            Text(viewModel.notification.username)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            +
            Text(viewModel.notification.type.notificationMessage)
                .font(.system(size: 15))
                .foregroundColor(.black)
            +
            Text(" \(viewModel.timestampString)")
                .foregroundColor(.gray)
                .font(.system(size: 12))
            
        }}
            
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post{
                    Button {
                        postViewModel.currentPost = post
                        isPopupBarPresented = true
                        isPopupOpen = true
                    
                    } label: {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            
                            .clipped()
                    }
                    

                }
            } else{
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Following": "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 100, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? .white : Color("CassettaOrange"))
                        .cornerRadius(15)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        }
                }

            }
        }
        .padding()
        .frame(maxWidth: UIScreen.screenWidth - 12 )
        .frame(minHeight: 80)
        .background(.white)
        .cornerRadius(15.0)
        
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var post = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        ZStack {
            Color("CassettaTan").edgesIgnoringSafeArea(.all)
            NotificationCell(viewModel: NotificationCellViewModel(notification: Notification(username: "nickssalazr23465", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/cassetta-production.appspot.com/o/profile_images%2FC9BCB365-335B-4D21-80D6-E71F54E4A671?alt=media&token=43b1000f-dbbf-4e54-b366-59fbce5901b8", timestamp: Timestamp(), type: .like, uid: "OlWrOF8N9YX43S2iuLiJUUKx7R32")) , isPopupBarPresented: .constant(false), isPopupOpen: .constant(false), postViewModel: PostViewModel(post: post))
                .previewLayout(.sizeThatFits)
                
        }
    }
}
