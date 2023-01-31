//
//  MiniPlayerView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/18/22.
//

import SwiftUI
import Combine


struct MiniPlayerView: View {
    
   
    
    var body: some View {
        GeometryReader { proxy in
            
            HStack {
                
                Image("GenericImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35.0, height: 35.0)
                    .cornerRadius(5)
                
                VStack(alignment: .leading){
                    Text("The DIFFERENCE between the 5 boroughs (are the STEREOTYPES true)?")
                        .fontWeight(.bold)
                        .lineLimit(1)
                    //.matchedGeometryEffect(id: "Label", in: animationNamespaceId)
                    
                    Text("Jessica Johnson")
                }
                .frame(width: UIScreen.screenWidth / 1.8)
                
                Group {
                    Button(action: {}, label: {
                        
                        Image(systemName: "play.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                    
                    Button(action: {
                      //  self.minimizableViewHandler.dismiss()
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                }
                .padding(.leading)
                
            }
            .frame(width: proxy.size.width, height: proxy.size.height)

            
        }
        .transition(AnyTransition.asymmetric(insertion: AnyTransition.opacity.animation(.easeIn(duration: 0.5)), removal: AnyTransition.opacity.animation(.easeOut(duration: 0.1))))
    }
}

struct MiniPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayerView()
    }
}
