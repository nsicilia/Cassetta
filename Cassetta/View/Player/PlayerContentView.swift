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
    @State var likeValue: Bool = false
    @State var dislikeValue: Bool = false
    
    //The post
    let post: Post
    
    var body: some View {
        ScrollView{
            
            Group{
                
               // Image("DefaultImage")
               // Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: post.imageUrl)!)) ?? UIImage(named: "DefaultImage")!)
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.screenWidth / 1.1, height: UIScreen.screenWidth / 1.4)
                    .cornerRadius(15)
                    
                //the title
                Text(post.title)
                    
                    .font(.title)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .lineLimit(8)
                    .padding([.horizontal, .top], 32)
                
                
                HStack(spacing: 0){
                    
                    HStack(spacing: 1){
                        Text("173k")
                        Text("🎧")
                    }
                    
                    
                    Spacer()
                    
                    HStack(spacing: 1){
                        Text("13k")
                        Text("💬")
                    }
                    
                    
                    Spacer()
                    
                    //Like button
                    Button(action: {
                        //set like value
                        likeValue.toggle()
                        dislikeValue = false
                    }, label: {
                        HStack{
                            Text("13k")
                                .foregroundColor(.black)
                            
                            Image(systemName: likeValue ? "heart.fill" : "heart")
                                .resizable()
                                .foregroundColor(likeValue ? .red : .gray)
                                .frame(width: 20, height: 18)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        
                    })
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("CassettaBorder"), lineWidth: 2)
                    )
                    
                    Spacer()
                    
                    //Dislike button
                    Button(action: {
                        //todo
                        dislikeValue.toggle()
                        likeValue = false
                    }, label: {
                        HStack{
                            Text("13k")
                                .foregroundColor(.black)
                            
                            Image(systemName: dislikeValue ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                                .resizable()
                                .foregroundColor(dislikeValue ? .blue : .gray)
                                
                                .frame(width: 21, height: 21)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                    })
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("CassettaBorder"), lineWidth: 2)
                    )
                    
                    
                    
                }
                .padding()
                .frame(width: UIScreen.screenWidth / 1.1 )
                
                Text("Swipe for comments ➡️")
                
                LazyVStack(spacing: 15){
                    Text(post.description)
                        .padding([.horizontal, .top], 32)
                }
                
            }
            .padding(.horizontal)
            .onTapGesture {
                //placeholder to make the scrollview work for whatever reason
            }
        }
    }
}



struct PlayerContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerContentView(post: Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3))
    }
}
