//
//  PlayerContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI

struct PlayerContentView: View {
    var body: some View {
        ScrollView{
            
            Group{
                
                Image("Flower")
                    .resizable()
                    .frame(width: UIScreen.screenWidth / 1.1, height: UIScreen.screenWidth / 1.4)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(5)
                
                Text("The DIFFERENCE between the 5 boroughs (are the STEREOTYPES true)?")
                    .font(.title)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .padding([.horizontal, .top], 32)
                
                
                HStack{
                    
                    Button(action: {
                        //todo
                    }, label: {
                        HStack{
                            Text("13k")
                            Text("💬")
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        //todo
                    }, label: {
                        Image(systemName: "heart")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        //todo
                    }, label: {
                        Image(systemName: "hand.thumbsdown")
                    })
                    
                }
                .padding()
                .frame(width: UIScreen.screenWidth / 2 )
                
                Text("Swipe for comments ➡️")
                
                LazyVStack(spacing: 15){
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                        .padding([.horizontal, .top], 32)
                    
                    Image("GenericImage")
                        .resizable()
                        .scaledToFit()
                        .padding([.horizontal, .top], 32)
                    
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
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
