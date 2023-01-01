//
//  RecordingsList.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/21/22.
//

import SwiftUI

struct RecordingsList: View {
    @ObservedObject var audioRecorder: AudioRecorderViewModel
    
    var body: some View {
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
            //apply the delete functionallity to to every RecordingRow in the RecordingList
            .onDelete(perform: delete)
        }
        
    }
    
    //MARK: Delete recordings
    func delete(at offsets: IndexSet){
        //array of the file paths
        var urlsToDelete = [URL]()
        //offsets argument represents a set of indexes of recording rows that the user has chosen to delete
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}



struct RecordingRow: View{
    var audioURL: URL
    
    @ObservedObject var audioPlayer = PreviewAudioPlayerViewModel()
    
    var body: some View{
        
        HStack{
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            
            //MARK: Play/Stop Button
            if audioPlayer.isPlaying == false {
                //Audio is not playing
                Button {
                    self.audioPlayer.prepPlayback(audio: self.audioURL)
                    self.audioPlayer.playPlayback()
                    print("Start playing audio")
                } label: {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
                
            }else{
                //Audio is playing
                Button {
                    print("Stop playing audio")
                    self.audioPlayer.stopPlayback()
                } label: {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
                
            }
        }
        
    }
    
}




struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList(audioRecorder: AudioRecorderViewModel())
    }
}
