//
//  PlayerContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI

struct PlayerContentView: View {
    @State var likeValue: Bool = false
    @State var dislikeValue: Bool = false
    
    var body: some View {
        ScrollView{
            
            Group{
                
                Image("RecordPlayer")
                    .resizable()
                    .frame(width: UIScreen.screenWidth / 1.1, height: UIScreen.screenWidth / 1.4)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(5)
                
                Text("5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!")
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
                    Text("Are you a music lover who thought you knew everything there is to know about records? Think again! In this video, we uncover five shocking facts about records that will change the way you listen to music forever. From the secret messages hidden in early vinyl pressings to the surprising number of records still sold today, this video is packed with information that will blow your mind. Don't believe us? Watch the video and see for yourself. Trust us, you won't be disappointed. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
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
        PlayerContentView()
    }
}
