//
//  UserCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/22.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack{
            
            //Image
            Image("GenericUser")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
                .clipShape(Circle())
            //username, fullname
            VStack(alignment: .leading){
            Text("Jessica Johnson")
                    .font(.system(size: 12))
                
//            Text("Jessica Johnson")
//                    .font(.system(size: 14))
            }
            //Spacer()
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
