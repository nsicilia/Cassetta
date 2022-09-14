//
//  Card.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/11/22.
//

import SwiftUI

struct Card: View {
    var body: some View {
        VStack{
            HStack(alignment: .top){
                VStack{
                    //Image
                    Image("Flower")
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: UIScreen.main.bounds.width / 3,
                            height: UIScreen.main.bounds.width / 3
                        )
                        .cornerRadius(15.0)
                    
                    Spacer()
                    
                    ListenLikeCount(ListenCount: 12222, LikeCount: 234567)
                        .padding(.top, 8)
                }
                
                VStack(alignment: .leading) {
                    Text("Unde aut dolores neque nesciunt alias voluptas qui qui id.")
                        .font(.system(size: 18))
                        .bold()
                    
                    UserCell()
                    
                    Spacer()
                    HStack{
                        
                        Spacer()
                        
                        Button {
                            print("Edit button was tapped")
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .font(.title)
                                .foregroundColor(.black)
                            Text("Play")
                                .foregroundColor(.black)
                        }
                        .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 6))
                        .background(.white)
                        .cornerRadius(12.0)
                        .shadow(color: Color.black.opacity(0.2), radius: 8)
                    }
                    
                }
                .padding(.leading, 4)
                
            }
            
        }
        .padding([.bottom, .top])
        .padding([.leading, .trailing], 8)
        .frame(maxWidth: UIScreen.main.bounds.width - 10.0, maxHeight: 230.0, alignment: .top)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15.0)
        .shadow(color: Color.black.opacity(0.2), radius: 8)
        
    }
    
}
struct Card_Previews_light: PreviewProvider {
    static var previews: some View {
        Card()
    }
}
struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card()
            .preferredColorScheme(.dark)
    }
}
    
