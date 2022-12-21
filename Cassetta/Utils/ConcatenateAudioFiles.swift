//
//  ConcatenateAudioFiles.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/21/22.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class ConcatenateAudioFiles {
    
    var mergeAudioURL = NSURL()

    
    func createArray(audioRecorder:AudioRecorderViewModel) async throws -> URL{
        var soundArray = [URL]()
        
        for recording in audioRecorder.recordings{
            soundArray.append(recording.fileURL)
        }

       //mergeAudioFiles(audioFileUrls: soundArray)
        let outputURL = try await concatenateAudioFiles(urls: soundArray)
        
        //return mergeAudioURL as URL
        return outputURL
    }
    
    
    func concatenateAudioFiles(urls: [URL]) async throws -> URL {
        let composition = AVMutableComposition()
        
        let checkURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("concatenated.m4a")
        
        deleteFinalRecording(urlToDelete: checkURL)

        // Add audio tracks from each URL to the composition
        for url in urls {
            let asset = AVURLAsset(url: url)
            for track in asset.tracks(withMediaType: .audio) {
                let compositionTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
                try compositionTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: asset.duration), of: track, at: composition.duration)
            }
        }

        // Export the composition to a new audio file
        let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("concatenated.m4a")
        exportSession?.outputURL = tempURL
        exportSession?.outputFileType = .m4a
        await exportSession?.export()

        return tempURL
    }
    
    
    func deleteFinalRecording(urlToDelete: URL){
        
            print("DEBUG:deleteRecording - URL attempting to delete \(urlToDelete)")
            
            do{
                try FileManager.default.removeItem(at: urlToDelete)
                print("DEBUG:deleteRecording - Sucessfully deleted \(urlToDelete)")
            } catch{
                print("DEBUG:deleteRecording - File could not be deleted!")
            }
            
        
    }

}
