//
//  ContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/7/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
        UINavigationBar.appearance().barTintColor = UIColor.systemBackground
        
    }
    
    
    var body: some View {
        
        TabBarView()
        .accentColor(Color("CassettaOrange"))

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
    }
}
