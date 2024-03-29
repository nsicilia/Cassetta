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
        
        ZStack {
            
            Group {
                if viewModel.userSession == nil{
                    //LoginView()
                    
                        PhoneLoginView()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    
                } else{
                    if let user = viewModel.currentUser{
                        TabBarView(user: user)
                        //MainTabView(user: user)
                    }
                }
            }
        }
//        .onAppear(){
//            viewModel.signout()
//        }
            
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
