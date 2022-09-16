//
//  HighlightCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/15/22.
//

import SwiftUI

struct HighlightCell: View {
    var body: some View {
        ZStack{
            Image("Flower")
                .resizable()
                .scaledToFill()
                .frame(width: 330, height: 180)
                .clipped()
                .cornerRadius(15)
                .brightness(-0.5)
                .overlay {
                    VStack{
                        HStack{
                            
                            Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr")
                                .font(.system(.title))
                                .foregroundColor(.white)
                                .padding([.leading, .top])
                            
                            
                            Spacer()
                        }
                        Spacer()
                        HStack{
                            Spacer()
                            
                            Image(systemName: "play.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("25 mins")
                                .foregroundColor(.white)
                        }
                        .padding([.trailing, .bottom], 12)
                    }
                }
            
            
        }
    }
}

struct HighlightCell_Previews: PreviewProvider {
    static var previews: some View {
        HighlightCell()
    }
}
