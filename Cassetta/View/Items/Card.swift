//
//  Card.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/11/22.
//

import SwiftUI
import Firebase
import Kingfisher

struct Card: View {
    let post: Post
    let currentUserCard: Bool = true
    
    
    var body: some View {
        VStack{
            
            VStack{
                //Post Image
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.screenWidth / 1.1, height: UIScreen.screenWidth / 1.4)
                    .cornerRadius(15.0)
                
                //Title
                Text(post.title)
                // .multilineTextAlignment(.center)
                //Text("The DIFFERENCE between the 5 boroughs (are the STEREOTYPES true)?")
                    .frame(width: UIScreen.main.bounds.width / 1.18)
                    .lineLimit(3)
                    .font(.system(size: 18, weight: .semibold))
            }
            
            NavigationLink {
                Text("User Profile")
            } label: {
                UserCell(ownerFullname: post.ownerFullname, ownerImageUrl: post.ownerImageUrl, ownerUsername: post.ownerUsername)
            }
            
            // Spacer()
            
            HStack{
                ListenLikeCount(ListenCount: 12222, LikeCount: 234567)
                
                Spacer()
                
                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 15))
                        .foregroundColor(Color("CassettaBlack"))
                    Text(DateComponentsFormatter.abbreviated.string(from: post.duration ) ?? "00:00")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
            }
            .frame(width: 330.0)
            
        }
        .padding([.bottom, .top], 13)
       // .padding([.leading, .trailing], 8)
        .frame(maxWidth: UIScreen.screenWidth - 14.0, alignment: .top)
        .background(Color("CassettaWhite"))
        .cornerRadius(15.0)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("CassettaBorder"), lineWidth: 1)
            
        }
        
    }
    
}
struct Card_Previews_light: PreviewProvider {
    static var previews: some View {
        Card(post: Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 1300.0, listens: 3))
    }
}

//struct Card_Previews: PreviewProvider {
//    static var previews: some View {
//        Card(post: Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!"))
//            .preferredColorScheme(.dark)
//    }
//}

