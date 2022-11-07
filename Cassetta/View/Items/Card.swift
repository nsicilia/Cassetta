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
            
            VStack{
                //Image
                Image("GenericImage")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        //width: 330.0,
                        width: UIScreen.main.bounds.width / 1.18,
                        
                       // height: 180.0
                        height: UIScreen.main.bounds.height / 4.7
                    )
                    .cornerRadius(15.0)
                
                
                Text("How to Become a Cats Influencer in Three Easy Steps")
                    .frame(width: 330)
                    .lineLimit(3)
                    .font(.system(size: 18, weight: .semibold))
            }
            
            
            UserCell()
            
            Spacer()
            
            HStack{
                ListenLikeCount(ListenCount: 12222, LikeCount: 234567)
                
                Spacer()
                
                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 15))
                        .foregroundColor(Color("CassettaBlack"))
                    Text("25 mins")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
            }
            .frame(width: 330.0)
            
            
            
            
            
        }
        .padding([.bottom, .top], 24)
        .padding([.leading, .trailing], 8)
        .frame(maxWidth: UIScreen.main.bounds.width - 15.0, maxHeight: UIScreen.main.bounds.height / 2.4, alignment: .top)
        .background(Color("CassettaWhite"))
        .cornerRadius(15.0)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("CassettaBorder"), lineWidth: 1)
            
        }
        //.shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 6)
        
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

