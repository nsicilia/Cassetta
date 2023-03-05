//
//  Feed.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 6/8/22.
//

import SwiftUI

import Firebase

struct Feed: View {
    //@EnvironmentObject var miniHandler: MinimizableViewHandler
    //The Feed view model
    @ObservedObject var viewModel: FeedViewModel
    
    //The Popup vars
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    
   // @Binding var PlayingPost: Post?
    
    //Testnew post view model
    @ObservedObject var postViewModel: PostViewModel
    
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack {
                ForEach(viewModel.posts) { post in
                    
                    Button {
                        //PlayingPost = post
                        postViewModel.playingPost = post
                        isPopupBarPresented = true
                        isPopupOpen = true
                    } label: {
                        Card(post: post)
                    }
                    .tint(.black)
                    .padding(.bottom, 12)
                    
//                    Card(post: post)
//                        .onTapGesture {
//                            PlayingPost = post
//                            isPopupBarPresented = true
//                        }
                    
                }
                
            }
            .padding(.top)
            .background(Color("CassettaTan"))
        }
        //
    }
    
}

struct Feed_Previews: PreviewProvider {
    
    static var post = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        Feed( viewModel: FeedViewModel(config: .explore), isPopupBarPresented: .constant(true), isPopupOpen: .constant(true), postViewModel: PostViewModel(post: post))
    }
}
