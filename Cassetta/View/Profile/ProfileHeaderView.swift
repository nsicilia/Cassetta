//
//  ProfileHeaderView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(alignment: .center){
            
            //Image
            VStack {
                Image("GenericUser")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding()
                
                HStack(spacing: 8){
                    //Stats
                    UserStatView(value: 15, title: "Posts")
                    UserStatView(value: 34, title: "Followers")
                    UserStatView(value: 64, title: "Following")
                }
                .padding(.trailing, 16)
            }
            
            //name
            Text("Jessica Johnson")
                .font(.system(size: 15, weight: .semibold))
                .padding(.top)
            
            //description
            Text("OH ✈️ NY ✈️ CA   |   ASU '19   |   fashion, travel & lifestyle")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 32)
                .padding(.top, 1)
            
            
            VStack {
                //Buttons
                ProfileActionButtonView()

            }
            .padding(.top)
            
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
