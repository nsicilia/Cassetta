//
//  AudioRecorderViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/21/22.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorderViewModel: NSObject, ObservableObject {
    
    //fetchRecordings function should be called when the app and therefore also the AudioRecorder is launched for the first time
    override init() {
        super.init()
        fetchRecordings()
    }
    
    //passthrough object
    let objectWillChange = PassthroughSubject<AudioRecorderViewModel, Never>()
    
    //initialize an AVAudioRecorder instance
    var audioRecorder: AVAudioRecorder!
    
    //an array to hold the recordings
    var recordings = [Recording]()
    
    //update subscribing views on var change with objectWillChange
    var recording = false{
        didSet{
            objectWillChange.send(self)
        }
    }
    
    //MARK: Record audio function
    func startRecording(){
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        //define the type for our recording session and activate it
        do{
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
        } catch {
            print("DEBUG:AudioRecorder - Failed to set up recording session")
        }
        
        //location where the recording should be saved
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //file named after the date and time of the recording and has the .m4a format
        let audioFileName = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
        
        let settings = [
            AVEncoderBitRateKey: 32000,
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        

        
        //start the recording with audioRecorder property
        do{
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.record()
            //inform contentview(subcribed views) that recording is running
            recording = true
            
        } catch{
            print("DEBUG:AudioRecorder - Could not start recording")
        }
        
    }
    
    //MARK: End the Recording Session
    func stopRecording(){
        audioRecorder.stop()
        //inform contentview(subcribed views) that recording has ended
        recording = false
        
        //calls the fetchRecordings() everytime a recording is completed
        fetchRecordings()
    }
    
    //MARK: access the stored recordings
    func fetchRecordings(){
        //empty the array
        recordings.removeAll()
        
        //access the documents folder where the audio files are located
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        
        //loop through all documents
        for audio in directoryContents {
            //create a Recording instance for the individual audio file
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            //add to the array
            recordings.append(recording)
        }
        
        //sort the recordings array by the creation date
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        
        //update all observing views
        objectWillChange.send(self)
    }
    
    
    //MARK: Delete accepted array of audio recordings
    //accepts an array of urls and deletes the corresponding files from the document folder
    func deleteRecording(urlsToDelete: [URL]){
        
        for url in urlsToDelete {
            print("DEBUG:deleteRecording - URL attempting to delete \(url)")
            
            do{
                try FileManager.default.removeItem(at: url)
                print("DEBUG:deleteRecording - Sucessfully deleted \(url)")
            } catch{
                print("DEBUG:deleteRecording - File could not be deleted!")
            }
            
            //update our recordings array using the fetchRecording
            fetchRecordings()
        }
    }
    
    
}

