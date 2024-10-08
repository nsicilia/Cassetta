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

    @Published var recordingDuration: String = "00:00:00" {
        didSet{
            objectWillChange.send(self)
        }
    }
    
    var timerTest: Timer?
    
    //MARK: Record audio function
    func startRecording(){
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        //define the type for our recording session and activate it
        do{
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
        } catch {
          //  print("DEBUG:AudioRecorder - Failed to set up recording session")
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
            //test timer
            guard timerTest == nil else { return }
            timerTest = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let time = self.audioRecorder.currentTime
                let hours = Int(time) / 3600
                let minutes = Int(time) / 60 % 60
                let seconds = Int(time) % 60
                self.recordingDuration = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
                print("scheduledTimer: running")
            }
            //inform contentview(subcribed views) that recording is running
            recording = true
            
        } catch{
            //print("DEBUG:AudioRecorder - Could not start recording")
        }
        
    }
    
    //MARK: End the Recording Session
    func stopRecording(){
        //Get the url of the recording
        let recordingURL = audioRecorder.url
        audioRecorder.stop()
        //inform contentview(subcribed views) that recording has ended
        recording = false
        
        //test timer
        timerTest?.invalidate()
        timerTest = nil
        self.recordingDuration = "00:00:00"
        
        //Trim the recording by 0.053 seconds
        trimRecording(recordingURL: recordingURL)
        
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
           // print("DEBUG: AudioRecordingViewModel - createAt: \(recording.createdAt) name: \(recording.fileURL.lastPathComponent)")
        }
        
        //sort the recordings array by the creation date
       // recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        //recordings.sort(by: {$0.fileURL.lastPathComponent.compare($1.fileURL.lastPathComponent) == .orderedAscending})
        recordings.sort(by: {$0.createdAt.compare($1.createdAt) == .orderedAscending})
        
        DispatchQueue.main.async {
            //update all observing views
            self.objectWillChange.send(self)
        }
    }
    
    
    //MARK: Delete accepted array of audio recordings
    //accepts an array of urls and deletes the corresponding files from the document folder
    func deleteRecording(urlsToDelete: [URL]){
        
        for url in urlsToDelete {
           // print("DEBUG:deleteRecording - URL attempting to delete \(url)")
            
            do{
                try FileManager.default.removeItem(at: url)
               // print("DEBUG:deleteRecording - Sucessfully deleted \(url)")
            } catch{
                print("DEBUG:deleteRecording - File could not be deleted!")
            }
            
            //update our recordings array using the fetchRecording
            fetchRecordings()
        }
    }
    
    //MARK: function for trimming the last 0.053 off the end of an audio clip
    //This is for better flow between clips
    func trimRecording(recordingURL: URL) {
        let asset = AVURLAsset(url: recordingURL)
        let audioDuration = CMTimeGetSeconds(asset.duration)
        let trimmedDuration = audioDuration - 0.053
        let trimmedTime = CMTimeMakeWithSeconds(trimmedDuration, preferredTimescale: asset.duration.timescale)

        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A)!
        exportSession.outputURL = recordingURL
        exportSession.outputFileType = .m4a
        exportSession.timeRange = CMTimeRange(start: CMTime.zero, duration: trimmedTime)

        do {
            try FileManager.default.removeItem(at: recordingURL)
        } catch {
            print("Error deleting original recording file: \(error)")
        }

        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                
                print("Trimming completed successfully")
                self.fetchRecordings()
            case .failed:
                print("Trimming failed: \(exportSession.error!)")
            default:
                break
            }
        }
    }
    
    

    func addFileRecording(from url: URL) {
        // Get the default file manager instance
        let fileManager = FileManager.default
        
        // Get the path to the documents directory for the user's domain
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // Set the creation date attribute to the current date
        let attributes = [FileAttributeKey.creationDate: Date()]
        
        // Check if a recording with the same file name already exists in the recordings array
        let recordingExists = recordings.contains { (recordingInArray) -> Bool in
            return recordingInArray.fileURL.lastPathComponent == url.lastPathComponent
        }
        
        // If the recording exists, append the current time to the file name to avoid overwriting
        // Otherwise, use the original file name
        let destinationURL = documentsDirectory.appendingPathComponent(
            recordingExists ? "\(Date().toString(dateFormat: "HH:mm:ss"))\(url.lastPathComponent)" : "\(url.lastPathComponent)"
        )
        
        do {
            // Attempt to copy the file from the source URL to the destination URL
            try fileManager.copyItem(at: url, to: destinationURL)
            
            // Set the file's attributes (e.g., creation date)
            try fileManager.setAttributes(attributes, ofItemAtPath: destinationURL.path)
            
        } catch {
            // Handle errors in file copying or attribute setting
            return
        }
        
        // Create a new Recording object with the destination URL and current date
        let recording = Recording(fileURL: destinationURL, createdAt: Date())
        
        // Add the new recording to the recordings array
        recordings.append(recording)
        
        // Notify any observers that the object has changed
        objectWillChange.send(self)
        
        // Refresh the list of recordings
        fetchRecordings()
    }
    
    //MARK: function to delete all the recording stored in the app
    func deleteAllRecordings() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
            }
            self.fetchRecordings()
        } catch {
            print("DEBUG:AudioRecorder - Could not delete all recordings")
        }
    }


    
}

