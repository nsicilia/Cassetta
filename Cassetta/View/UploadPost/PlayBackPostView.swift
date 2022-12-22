//
//  PlayBackPostView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/12/22.
//

import SwiftUI

struct PlayBackPostView: View {
    @Binding var showStatus: Bool
    //PlayAudio
    @ObservedObject var audioPlayer = PreviewAudioPlayerViewModel()
    @ObservedObject var audioRecorder: AudioRecorderViewModel
    
    //Passed URL from recorder view
    @Binding var combinedURL: URL?
    
    var temp = false
    
    var body: some View {
        VStack {
            
            
            
            Text("01:34:23")
                .font(.largeTitle)
            
            HStack(spacing: 20){
                
                Button {
                    print("play combined audio")
                } label: {
                    //MARK: Play/Pause Button
                    if audioPlayer.isPlaying == false {
                        //Audio is not playing
                        Button {
                            
                            if let combined = combinedURL{
                                self.audioPlayer.startPlayback(audio: combined)
                            }
                                
                        
                            print("Start playing audio")
                            
                        } label: {
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        
                    }else{
                        //Audio is playing
                        Button {
                            print("Stop playing audio")
                            
                            //self.audioPlayer.stopPlayback()
                            
                                self.audioPlayer.pausePlayback()

                            
                        } label: {
                            Image(systemName: "stop.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        
                    }
                }
                
            }
            .padding(.top)
            
            
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
        PlayBackPostView(showStatus: .constant(true), audioRecorder: AudioRecorderViewModel(), combinedURL: .constant(URL(string: "https://www.apple.com")!))
    }
}
