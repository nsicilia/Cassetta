//
//  Feed.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 6/8/22.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack {
                ForEach(1...15, id: \.self) { count in
                    Card()
                        .padding(.bottom,8)
                }
                
            }
            .padding(.top)
            
        }
        .background(Color(.secondarySystemBackground))
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
