//
//  CategoryCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI

struct CategoryCell: View {
    var categoryTitle: String
    var cetegoryEmoji: String
    
    var body: some View {
        HStack{
            //Category title
            Text(categoryTitle)
                
            Spacer()
            
            //Emoji
            Text(cetegoryEmoji)
                .font(.largeTitle)
            
        }
        .padding([.leading, .trailing])
        .frame(width: (UIScreen.screenWidth / 2 ) - 20, height: 95)
        .background(Color("CassettaWhite"))
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(UIColor.secondaryLabel), lineWidth: 1)
        }
    }
}


struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(categoryTitle: "Fashion & Beauty", cetegoryEmoji: "💃")
    }
}
