//
//  UserCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/22.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let ownerFullname: String
    let ownerImageUrl: String
    let ownerUsername: String
    var fullInfo: Bool = false
    
    var body: some View {
        VStack{
            if !fullInfo{
                HStack{
                    //User Image
                    KFImage(URL(string: ownerImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                    
                    //username, fullname
                    VStack(alignment: .leading){
                        
                        Text(ownerUsername)
                            .font(.system(size: 12))
                        
                        //            Text("Jessica Johnson")
                        //                    .font(.system(size: 14))
                    }
                }
            } else {
                HStack{
                    //User Image
                    KFImage(URL(string: ownerImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    
                    //username, fullname
                    VStack(alignment: .leading){
                        
                        Text(ownerUsername)
                            .font(.system(size: 12, weight: .semibold))
                        
                        Text("Jessica Johnson")
                            .font(.system(size: 14))
                    }
                }
            }
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUsername: "jessica")
        
    }
}
