//
//  ContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/7/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {

        
        Group{
            if viewModel.userSession == nil{
                LoginView()
            } else{
                if let user = viewModel.currentUser{
                    TabBarView(user: user)
                }
            }
        }
            
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(AuthViewModel())
//    }
//}
