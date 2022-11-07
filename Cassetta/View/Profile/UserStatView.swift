//
//  UserStatView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    var body: some View{
        VStack{
            //count
            Text("\(value)")
                .font(.system(size: 15, weight: .semibold))
            
            //label
            Text(title)
                .font(.system(size: 15))
        }
        .frame(width: 80, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 5, title: "Posts")
    }
}
