//
//  ProfileActionButtonView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
    var isCurrentUser = false
    var isFollowed = false
    
    var body: some View {
        
        if isCurrentUser {
            //user profile edit button
            Button {
                //todo
            } label: {
                Text("Edit Profile")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 360, height: 32)
                    .foregroundColor(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    }
            }
            
        }else {
            //Follow button and message button
            HStack{
                
                
                //Follow button
                Button {
                    //todo
                } label: {
                    Text(isFollowed ? "Following": "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 170, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? .white : Color("CassettaOrange"))
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        }
                }

                
                //Message button
                Button {
                    //todo
                } label: {
                    Text("Message")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 170, height: 32)
                        .foregroundColor(Color("CassettaBlack"))
                        .background(Color("CassettaWhite"))
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                }
                
            }
            
        }
            
    }
}



struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView()
    }
}
