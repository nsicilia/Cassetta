//
//  Feed.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 6/8/22.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        ScrollView{
            LazyVStack {
                ForEach(1...10, id: \.self) { count in
                    Card()
                        .padding(.bottom,10)
                }
            }
            
            
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
