//
//  UserListView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/14/22.
//

import SwiftUI

struct UserListView: View {
    var body: some View {
        
        ScrollView{
            ForEach(0 ..< 20) { _ in
                HStack{
                    //User
                    UserCell()
                    
                    //Align Left
                    Spacer()
                }
                .padding([.leading, .trailing])
                .padding(.top, 8)
            }
            
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
