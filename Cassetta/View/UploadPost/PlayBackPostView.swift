//
//  PlayBackPostView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/12/22.
//

import SwiftUI

struct PlayBackPostView: View {
    @Binding var showStatus: Bool
    
    var body: some View {
        VStack {
            
            
            
            Text("01:34:23")
                .font(.largeTitle)
            
            BottomControlsView()
        }
        .toolbar {
            NavigationLink {
                DetailPostView(showStatus: $showStatus)
            } label: {
                Text("next")
                    .bold()
                    .frame(width: 80, height: 30)
                    .background(Color("CassettaOrange"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

        }
    }
}

struct PlayBackPostView_Previews: PreviewProvider {
    static var previews: some View {
        PlayBackPostView(showStatus: .constant(true))
    }
}
