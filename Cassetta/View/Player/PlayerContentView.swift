//
//  PlayerContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI
import Firebase

struct PlayerContentView: View {
    @State var likeValue: Bool = false
    @State var dislikeValue: Bool = false
    
    //The post
    let post: Post
    
    var body: some View {
        ScrollView{
            
            Group{
               // Image("DefaultImage")
                Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: post.imageUrl)!)) ?? UIImage(named: "DefaultImage")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.screenWidth / 1.1, height: UIScreen.screenWidth / 1.4)
                    .cornerRadius(5)
                    
                //the title
                Text(post.title)
                    .font(.title)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .padding([.horizontal, .top], 32)
                
                
                HStack{
                    
                    HStack(spacing: 2){
                        Text("173k")
                        Text("🎧")
                    }
                    
                    
                    Spacer()
                    
                    HStack(spacing: 2){
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
                                .frame(width: 23, height: 21)
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
                                
                                .frame(width: 23, height: 23)
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
        PlayerContentView(post: Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "A pineapple is a tropical fruit with a tough, spiky exterior and a juicy, sweet interior. It is known for its distinctive shape and golden yellow color, and is a popular ingredient in a variety of culinary dishes, both sweet and savory. Pineapple is also rich in vitamins, minerals and enzymes, making it a nutritious and delicious snack. To prepare a pineapple, the tough exterior is cut away, revealing the juicy and sweet flesh inside, which can be eaten fresh or used in recipes. Pineapples are grown in warm climates, such as Hawaii and South America.", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "3 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!"))
    }
}
