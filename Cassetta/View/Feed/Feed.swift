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
    
    //Status of the share/delete
    @State var theUser: Bool = false
    
    //Show a no posts
    @State var noPostDefault: Bool = true
    
    //Show no post pic
    @State var showNoPostPic: Bool = false
    
    //Testnew post view model
    @ObservedObject var postViewModel: PostViewModel
    
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack {
                //No Posts
                if(viewModel.posts.isEmpty && noPostDefault){
                    VStack{
                        if (theUser){
                            Text("Create your first post by clicking the + button below!")
                                .font(.title3)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenWidth / 2)
                                .multilineTextAlignment(.center)
                                .padding()
                        
                        
                        } else {
                            if(showNoPostPic){
                                Image("EmptyFeed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 250)
                                    .padding(.top, 25)
                                    .padding(.bottom, 25)
                            }
                            
                            
                            Text("No posts yet")
                                .font(.title2)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                                .frame(width: 250)
                                .padding(.top, 25)
                                .padding(.bottom, 25)
                        }
                            
                    
                    }
                    .padding([.leading, .trailing], UIScreen.screenWidth / 6)
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.bottom, 100)
                }
                //Posts to show
                ForEach(viewModel.posts) { post in
                    VStack{
                        
                        if theUser {
                            UserCardOptions(post: post,  viewModelposts: viewModel)
                                
                        }
                        
                        Button {
                            postViewModel.currentPost = post
                            isPopupBarPresented = true
                            isPopupOpen = true
                        } label: {
                            
                            Card(post: post)
                        }
                        .tint(.black)
                        .padding(.bottom, 12)
                        
                    }
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
        Feed( viewModel: FeedViewModel(config: .category("Book")), isPopupBarPresented: .constant(true), isPopupOpen: .constant(true), postViewModel: PostViewModel(post: post))
    }
}
