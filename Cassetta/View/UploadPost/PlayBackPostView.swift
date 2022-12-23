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
    
    @State private var value: Double = 0.0
    
    @State private var isEditing: Bool = false
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()

    
    var temp = false
    
    var body: some View {
        VStack {
            Text("01:34:23")
                .font(.largeTitle)
            

                VStack(spacing: 5){
                    Slider(value: $value, in: 0...(audioPlayer.audioPlayer?.duration ?? 60)){ editing in
                        
                        isEditing = editing
                        
                        if !editing{
                            audioPlayer.audioPlayer?.currentTime = value
                        }
                }
                .tint(.white)
                
                //MARK: Playback Time
                HStack{
                    Text("0:00")
                    Spacer()
                    Text("1:00")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }

            
            
            HStack(spacing: 20){
                //MARK: Play/Pause Button
                if audioPlayer.isPlaying == false {
                    //Audio is not playing
                    Button {
                        self.audioPlayer.playPlayback()
                        
                    } label: {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }
                    
                }else{
                    //Audio is playing
                    Button {
                        self.audioPlayer.pausePlayback()
                    } label: {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.top)
            
        }
        .onAppear {
            Task{
                combinedURL = try! await ConcatenateAudioFiles().createArray(audioRecorder: audioRecorder)
                if let combined = combinedURL{
                    self.audioPlayer.startPlayback(audio: combined)
                }
            }
        }
        .onReceive(timer) { _ in
            guard let player = audioPlayer.audioPlayer, !isEditing else {return}
            value = player.currentTime
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
