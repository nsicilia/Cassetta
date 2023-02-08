//
//  BottomControlsView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI

struct BottomControlsView: View {
    
    @State private var value: Double = 00.0
    
    var audioManager: AudioManager
    
    @State private var isEditing: Bool = false
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    
    var body: some View {
        ZStack{
            
            VStack {
                //Divider()
                
                //MARK: Playback
                VStack(spacing: 5){
                    
                    
                    Slider(value: $value, in: 0...(audioManager.player.duration))
                    { editing in

                        isEditing = editing

                        if !editing {
                            audioManager.seekPlayer(timeInSec: value)
                        }
                    }
                        .tint(Color("CassettaOrange"))

                    
                    //MARK: Playback Time
                    
                    HStack{
                        Text(DateComponentsFormatter.positional.string(from: audioManager.player.progress ) ?? "00:00")
                        Spacer()
                        Text(DateComponentsFormatter.positional.string(from: audioManager.player.duration ) ?? "00:00")
                    }
                    .font(.caption)
                    .foregroundColor(.black)
                    
                }
                .frame(width: UIScreen.screenWidth - 30)
                
                HStack{
                    Button {
                        //go backward ten
                        audioManager.backwardTen()
                    } label: {
                        Image(systemName: "gobackward.10")
                            .font(.title)
                            .foregroundColor(.black)
                    }

                    
                    Spacer()
                    Button {
                        audioManager.playingStatus.toggle()
                        if audioManager.playingStatus {
                            audioManager.player.resume()
                            print("DEBUG: \(audioManager.player.state)")
                            
                        } else{
                            audioManager.player.pause()
                            print("DEBUG: \(audioManager.player.state)")
                            
                        }
                        
                    } label: {
                        Image(systemName: audioManager.playingStatus ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    Button {
                        //Skip forward ten
                        audioManager.forwardTen()
                    } label: {
                        Image(systemName: "goforward.10")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                .frame(width: UIScreen.screenWidth / 2.5)
                .padding(.vertical, 10)
                .font(.largeTitle)
            .frame(maxWidth: .infinity)
            }
            .onReceive(timer) { _ in
                if !isEditing {
                    value = audioManager.player.progress
                }
            }
            
        }
        .background(Color.white)
        
        
    }
}

struct BottomControlsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomControlsView(audioManager: AudioManager())
    }
}
