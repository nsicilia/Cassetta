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
            
            Feed()
            
        }
        
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
