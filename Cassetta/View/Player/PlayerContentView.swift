//
//  PlayerContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI
import Firebase
import Kingfisher

struct PlayerContentView: View {
   // @ObservedObject var postInfoVM: PostInfoViewModel
    
    //var likeValue: Bool {return postInfoVM.post.didLike ?? false}
    //var dislikeValue: Bool {return postInfoVM.post.didDislike ?? false}
    
    //The post
    //let post: Post
    
    //post SOT
    @ObservedObject var postViewModel: PostViewModel
    
    //Popupview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    
    //the post profile nav status
    @Binding var showPosterProfile: Bool
    
    var likeValue: Bool {return postViewModel.currentPost?.didLike ?? false}
    var dislikeValue: Bool {return postViewModel.currentPost?.didDislike ?? false}
    
    var body: some View {
        ScrollView{
            
            //Group{
                KFImage(URL(string: postViewModel.currentPost?.imageUrl ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.screenWidth / 1.1, height: UIScreen.screenWidth / 1.4)
                    .cornerRadius(15)
                    
                //the title
                Text(postViewModel.currentPost?.title ?? "Title")
                    
                    .font(.title)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .lineLimit(8)
                    .padding([.horizontal, .top], 32)
            
            
            
            Button {
               // dd
                isPopupOpen = false
                showPosterProfile = true
                
            } label: {
                UserCell(ownerFullname: postViewModel.currentPost?.ownerFullname ?? "", ownerImageUrl: postViewModel.currentPost?.ownerImageUrl ?? "", ownerUsername: postViewModel.currentPost?.ownerUsername ?? "", fullInfo: true)
            }
            .foregroundColor(.black)
            .padding([.horizontal], 36)
                
            
                PlayerLikeListenCell(postViewModel: postViewModel)
                
                                    
                    Text("Swipe for comments ➡️")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top, 8)
                    
                    LazyVStack(spacing: 15){
                        Text(postViewModel.currentPost?.description ?? "Description")
                            .padding([.horizontal, .top], 32)
                    }
                
                
//            }
//            .padding(.horizontal)
//            .onTapGesture {
//                //placeholder to make the scrollview work for whatever reason
//            }
        }
    }
}



struct PlayerContentView_Previews: PreviewProvider {
    static let post = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        PlayerContentView(postViewModel: PostViewModel(post: post), isPopupBarPresented: .constant(false), isPopupOpen: .constant(false), showPosterProfile: .constant(false))
    }
}
