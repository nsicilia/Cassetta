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
        //Get the url of the recording
        let recordingURL = audioRecorder.url
        audioRecorder.stop()
        //inform contentview(subcribed views) that recording has ended
        recording = false
        
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
            print("DEBUG: AudioRecordingViewModel - createAt: \(recording.createdAt) name: \(recording.fileURL.lastPathComponent)")
        }
        
        //sort the recordings array by the creation date
       // recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        //recordings.sort(by: {$0.fileURL.lastPathComponent.compare($1.fileURL.lastPathComponent) == .orderedAscending})
        recordings.sort(by: {$0.createdAt.compare($1.createdAt) == .orderedAscending})
        
        //update all observing views
        objectWillChange.send(self)
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
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let attributes = [FileAttributeKey.creationDate: Date()]
        //let destinationURL = documentsDirectory.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss"))"+"\(url.lastPathComponent)")
        
        let recordingExists = recordings.contains { (recordingInArray) -> Bool in
            return recordingInArray.fileURL.lastPathComponent == url.lastPathComponent
        }
        
        
        let destinationURL = documentsDirectory.appendingPathComponent( recordingExists ? "\(Date().toString(dateFormat: "HH:mm:ss"))\(url.lastPathComponent)" : "\(url.lastPathComponent)")
        
        
        do {
            try fileManager.copyItem(at: url, to: destinationURL)
            try fileManager.setAttributes(attributes, ofItemAtPath: destinationURL.path)

            
        } catch {
            //print("DEBUG: AudioRecorderViewModel - Error copying file: \(error)")
            return
        }
        
        
        let recording = Recording(fileURL: destinationURL, createdAt: Date())
        //print("DEBUG: AudioRecordingViewModel: the recording createdAt - \(recording.createdAt)")
        recordings.append(recording)
        objectWillChange.send(self)
        
        fetchRecordings()
    }


    
    
}

