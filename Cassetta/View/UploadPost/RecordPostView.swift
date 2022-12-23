//
//  UploadPostView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/22.
//

import SwiftUI

struct RecordPostView: View {
    //create audioRecorder
    @ObservedObject var audioRecorder: AudioRecorderViewModel
    @Binding var showStatus: Bool
    @State var fileName = ""
    @State var fileURL: URL = URL(fileURLWithPath: "")
    @State var openfile = false
    //create var for combined url
    @State var combinedURL: URL?
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0){
                
                Spacer()
                
                Text("Swipe to delete recording ⬅️")
                    .padding(.vertical, 8)
                
                //MARK: Recordings List
                RecordingsList(audioRecorder: audioRecorder)
                

                
                
                VStack {
                    Text("00:00:00")
                        .font(.system(size: 24))
                        .padding(.bottom)
                    
                    HStack{
                        Spacer()
                        
                        
                        //The Upload a file Button
//                        HStack {
//                            Button {
//                                //todo
//                                openfile.toggle()
//                            } label: {
//                                Image("UploadAudio")
//                                    .resizable()
//                                    .frame(width: 45, height: 45)
//                                    .foregroundColor(.black)
//                            }
//                            .fileImporter(isPresented: $openfile, allowedContentTypes: [.audio]) { result in
//                                do{
//                                    let fileURL = try result.get()
//                                    print("THEFILE: \(String(describing: fileURL))")
//
//                                    self.fileName = fileURL.lastPathComponent
//                                    self.fileURL = fileURL
//                                }
//                                catch{
//                                    print("error reading docs\(error.localizedDescription)")
//                                }
//                            }
//                        }
//                        .frame(width: UIScreen.screenWidth * 0.001)
                        
                        
                        //Record an audio segment button
                        HStack {
                            
                            //MARK: The record button if/else
                            if audioRecorder.recording == false {
                                Button {
                                    print("Start recording")
                                    self.audioRecorder.startRecording()
                                } label: {
                        
                                    Circle()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.red)
                                        .padding(6)
                                        .overlay(Circle().stroke(.black, lineWidth: 4))
                                }
                                
                            } else {
                                
                                Button {
                                    print("Stop Recording")
                                    self.audioRecorder.stopRecording()
                                } label: {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.red)
                                        .padding(6)
                                        //.overlay(Circle().stroke(.black, lineWidth: 4))
                                }
                                
                            }//END: record button
                            
                        }
                        //.frame(width: UIScreen.screenWidth * 0.64)
                        
                        Spacer()
                    }
                    
                }
                .padding(.vertical, 40)
            .background(Color("CassettaTan"))
                
                
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        //close the view
                        showStatus.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink {
                        PlayBackPostView(showStatus: $showStatus, audioRecorder: audioRecorder, combinedURL: $combinedURL)
//                        CombinedAudioPlayerView(audioRecorder: audioRecorder, combinedURL: $combinedURL)
//                            .onAppear {
//                                Task{
//                                    combinedURL = try! await ConcatenateAudioFiles().createArray(audioRecorder: audioRecorder)
//                                }
//                            }
                        
                    } label: {
                        Text("Next")
                            .bold()
                            .frame(width: 80, height: 30)
                            .background(Color("CassettaOrange"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                
            }
        }
    }
}




struct RecordPostView_Previews: PreviewProvider {
    static var previews: some View {
        RecordPostView(audioRecorder: AudioRecorderViewModel(), showStatus: .constant(true))
    }
}



