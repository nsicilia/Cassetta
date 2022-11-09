//
//  ContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/7/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor.systemBackground
//        UINavigationBar.appearance().barTintColor = UIColor.systemBackground
//        
//    }
    
    var body: some View {
        
        //TabBarView()
        // Group{
        //if not logged in show loginview
        //else show main interface
        if $viewModel.userSession == nil{
            LoginView()
        } else{
            TabBarView()
        }
    //}

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
