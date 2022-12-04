//
//  BottomControlsView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI

struct BottomControlsView: View {
    var body: some View {
        ZStack{
            
            HStack{
                Button {
                    //todo
                } label: {
                    Image(systemName: "gobackward.15")
                        .font(.title)
                        .foregroundColor(.black)
                }

                
                Spacer()
                Button {
                    //todo
                } label: {
                    Image(systemName: "play.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                Spacer()
                Button {
                    //todo
                } label: {
                    Image(systemName: "goforward.15")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .frame(width: UIScreen.screenWidth / 2.5)
            .padding(.vertical)
            .padding()
            .font(.largeTitle)
            .frame(maxWidth: .infinity)
            
        }
        .background(Color.white)
    }
}

struct BottomControlsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomControlsView()
    }
}
