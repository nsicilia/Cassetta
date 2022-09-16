//
//  ListenLikeCount.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/14/22.
//

import SwiftUI

struct ListenLikeCount: View {
    
    var ListenCount: Int
    var LikeCount: Int
    
    var body: some View {
        HStack(spacing: 0){
            Text("❤️")
                .font(.title2)
                .padding(0)
            Text(String(ListenCount.roundedWithAbbreviations))
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.trailing)
            Text("🎧")
            Text(String(LikeCount.roundedWithAbbreviations))
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}




struct ListenLikeCount_Previews: PreviewProvider {
    static var previews: some View {
        ListenLikeCount(ListenCount: 101324, LikeCount: 160000)
    }
}
