//
//  CommentCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI
import Firebase
import Kingfisher

struct CommentCell: View {
    @State private var showPostImage = true
    
    let comment: Comment
    
    var body: some View {
        HStack(alignment: .top) {
            //Image
            KFImage(URL(string: comment.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            //Name + Comment
            VStack(alignment: .leading){
                Text(comment.username)
                    .font(.system(size: 14, weight: .semibold))
                
                Text(comment.commentText)
                    .font(.system(size: 15))
                    .padding(.bottom)
                
//                HStack{
//                    Button {
//                        //todo
//                    } label: {
//                        Image(systemName: "hand.thumbsup")
//                    }
//
//                    Spacer()
//
//                    Button {
//                        //todo
//                    } label: {
//                        Image(systemName: "hand.thumbsdown")
//                    }
//
//                    Spacer()
//
//                    Button {
//                        //todo
//                    } label: {
//                        Image(systemName: "text.bubble")
//                    }
//
//                }
//                .frame(width: UIScreen.screenWidth / 3)
                
            }
            Spacer()
        }
        .padding()
        .background(.white)
        .cornerRadius(15.0)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("CassettaBorder"), lineWidth: 2)
        )
    }
        
}

struct CommentCell_Previews: PreviewProvider {
    
    static let pst = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est.", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        ZStack {
           // Color("CassettaTan").edgesIgnoringSafeArea(.all)
            CommentCell(comment: Comment(username: "Test McUser", postOwnerUid: pst.ownerUid, profileImageUrl: pst.ownerImageUrl, commentText: "This is a comment about something!", timestamp: pst.timestamp, uid: "dsf"))
            
        }
    }
}
