//
//  UserCardOptions.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/7/23.
//

import SwiftUI
import FirebaseFirestore

struct UserCardOptions: View {
    
    @State private var isPresentingConfirm: Bool = false
    var post: Post?
    
    @ObservedObject var viewModel = DeletePostViewModel()
    @ObservedObject var viewModelposts: FeedViewModel
    
    
    var body: some View {
        HStack{
            Button {
                //todo
            } label: {
                HStack{
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
                .padding(.vertical, 6)
                .padding(.horizontal)
                .background(.white)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("CassettaBorder"), lineWidth: 2)
            )
            }
            
            Spacer()
            
            Button {
                isPresentingConfirm = true
            } label: {

                Image(systemName: "ellipsis")

                    .rotationEffect(Angle(degrees: 90))
                    .padding(.vertical)
                    .padding(.horizontal, 10)
                    .background(.white)
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("CassettaBorder"), lineWidth: 2)
                            
                )
                
                    
            }

            .confirmationDialog("Are you sure?",
                                isPresented: $isPresentingConfirm) {
                Button("Delete this post?", role: .destructive) {
                    if let post = post{
                        
                        viewModel.deletePost(post: post) { error in
                            print(error?.localizedDescription ?? "No error")
                        }
                        
                        if let index = viewModelposts.posts.firstIndex(of: post) {
                            viewModelposts.posts.remove(at: index)
                        }
                        
                    }
                }
                
            } message: {
                Text("You cannot undo this action")
                  }


            
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct UserCardOptions_Previews: PreviewProvider {
    static let pst = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est.", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    static var previews: some View {
        VStack{
            UserCardOptions(post: pst, viewModelposts: FeedViewModel(config: .explore))
        }
        .frame(height: UIScreen.screenHeight)
            .background(.gray)
            
    }
}
