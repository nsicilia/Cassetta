//
//  UserProfile.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 6/8/22.
//

import SwiftUI

struct UserProfile: View {
    var body: some View {
        
        ScrollView{
            Image("GenericUser")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 82.0, height: 82.0)
                .cornerRadius(.infinity)
                .padding(.top)
            Text("Jessica Schaefer")
                .font(.title2)
                .bold()
            Text("@jessschaefer54")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.bottom, 40)
            
            
            LazyVStack {
                ForEach(1...10, id: \.self) { count in
                    Card()
                        .padding(.bottom,10)
                }
            }
            
        }
        
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
