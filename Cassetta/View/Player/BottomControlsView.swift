//
//  BottomControlsView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI

struct BottomControlsView: View {
    
    @State private var value: Double = 00.0
    
    
    var body: some View {
        ZStack{
            
            VStack {
                //Divider()
                
                //MARK: Playback
                VStack(spacing: 5){
                    
                    
                    Slider(value: $value, in: 0...(60.0 ))
//                    { editing in
//
//                        isEditing = editing
//
//                        if !editing {
//                            audioManager.seekPlayer(timeInSec: value)
//                        }
//                    }
                        .tint(Color("CassettaOrange"))

                    
                    //MARK: Playback Time
                    
                    HStack{
                        Text("00:00")
                        Spacer()
                        Text("60:00")
                    }
                    .font(.caption)
                    .foregroundColor(.black)
                    
                }
                .frame(width: UIScreen.screenWidth - 30)
                
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
                .padding(.vertical, 10)
                .font(.largeTitle)
            .frame(maxWidth: .infinity)
            }
            
        }
        .background(Color.white)
        
        
    }
}

struct BottomControlsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomControlsView()
    }
}
