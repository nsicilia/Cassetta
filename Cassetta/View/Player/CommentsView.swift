//
//  CommentsView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI
import Firebase

struct CommentsView: View {
    @State  var input: String = ""
    
    @ObservedObject var viewModel: CommentViewModel
    
    init(post:Post){
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(){
//                CustomTextField(text: $input, placeholder: Text("Comment..."), imageName: "paperplane.fill", allLowerCase: false)
//
//                Text("Send")
                //Input
                CustomInputView(inputText: $input, action: uploadComment)
            }
            .frame(height: 40.0)
            .padding([.bottom, .top])
            .background(Color("CassettaTan").opacity(0.4))
            
            ScrollView{
                Group{
                    LazyVStack(spacing: 8){
                        if(!viewModel.comments.isEmpty){
                            ForEach(viewModel.comments) { comments in
                                CommentCell(comment: comments)
                            }//loop
                        }
                        else {
                            Text("Be the first to comment!")
                                .foregroundColor(.gray)
                                .padding(.top, 132)
                        }
                    }
                    .padding(.top)
                }
                
                .padding(.horizontal)
                .onTapGesture {
                    //placeholder to make the scrollview work for whatever reason
                }
            }
           // .background(Color("CassettaTan"))
        }
    }
    
    func uploadComment(){
        viewModel.uploadComment(commentText: input)
        input = ""
        UIApplication.shared.endEdit()
    }
}

struct CommentsView_Previews: PreviewProvider {
    
    static let pst = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est.", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        CommentsView(post: pst)
    }
}
