//
//  LazyView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 8/29/23.
//

import SwiftUI

struct LazyView<Content: View>: View {
    
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content){
        self.build = build
    }
    
    var body: Content{
        build()
    }
}
