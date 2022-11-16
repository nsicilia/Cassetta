//
//  UserProfile.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 6/8/22.
//

import SwiftUI

struct UserProfile: View {
    var body: some View {
        
        ScrollView(showsIndicators: false){
            ProfileHeaderView()
                .padding(.bottom)
            
            Divider()
                .frame(width: 350.0, height: 1.0)
                .overlay(Color("CassettaBrown"))
                .padding(.vertical)
            
            Feed()
            
        }
        .background(Color("CassettaTan"))
        
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
