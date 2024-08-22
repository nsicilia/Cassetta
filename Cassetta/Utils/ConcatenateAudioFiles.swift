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
import AudioKit

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
        
//        let temp2URL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("concatenated2.wav")
//        convertAudio(tempURL, outputURL: temp2URL)
        
        let temp2URL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("concatenated2.wav")

        var options = FormatConverter.Options()
        options.format = .wav
        options.sampleRate = 44100
        options.bitRate = 16
        options.channels = 2
        options.bitDepth = 16
        options.eraseFile = true
        options.isInterleaved = true


        let converter = FormatConverter(inputURL: tempURL, outputURL: temp2URL, options: options)

        converter.start { error in
           // the error will be nil on success
            print("DEBUG: \(String(describing: error))")
        }
        
//        let temp2URL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("concatenated2.mp3")
//        
//       
//        
//        
        return tempURL
    }
    
    
    func deleteFinalRecording(urlToDelete: URL){
        
        // print("DEBUG:deleteRecording - URL attempting to delete \(urlToDelete)")
        
        do{
            try FileManager.default.removeItem(at: urlToDelete)
            // print("DEBUG:deleteRecording - Sucessfully deleted \(urlToDelete)")
        } catch{
           // print("DEBUG:deleteRecording - File could not be deleted!")
        }
        
        
    }
    
    
    
    
    
    
    
    func convertAudio(_ url: URL, outputURL: URL) {
        var error : OSStatus = noErr
        var destinationFile: ExtAudioFileRef? = nil
        var sourceFile : ExtAudioFileRef? = nil

        var srcFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()
        var dstFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()

        ExtAudioFileOpenURL(url as CFURL, &sourceFile)

        var thePropertySize: UInt32 = UInt32(MemoryLayout.stride(ofValue: srcFormat))

        ExtAudioFileGetProperty(sourceFile!,
                                kExtAudioFileProperty_FileDataFormat,
                                &thePropertySize, &srcFormat)

        dstFormat.mSampleRate = 44100  //Set sample rate
        dstFormat.mFormatID = kAudioFormatLinearPCM
        dstFormat.mChannelsPerFrame = 1
        dstFormat.mBitsPerChannel = 16
        dstFormat.mBytesPerPacket = 2 * dstFormat.mChannelsPerFrame
        dstFormat.mBytesPerFrame = 2 * dstFormat.mChannelsPerFrame
        dstFormat.mFramesPerPacket = 1
        dstFormat.mFormatFlags = kLinearPCMFormatFlagIsPacked |
        kAudioFormatFlagIsSignedInteger

        // Create destination file
        error = ExtAudioFileCreateWithURL(
            outputURL as CFURL,
            kAudioFileWAVEType,
            &dstFormat,
            nil,
            AudioFileFlags.eraseFile.rawValue,
            &destinationFile)
        print("Error 1 in convertAudio: \(error.description)")

        error = ExtAudioFileSetProperty(sourceFile!,
                                        kExtAudioFileProperty_ClientDataFormat,
                                        thePropertySize,
                                        &dstFormat)
        print("Error 2 in convertAudio: \(error.description)")

        error = ExtAudioFileSetProperty(destinationFile!,
                                        kExtAudioFileProperty_ClientDataFormat,
                                        thePropertySize,
                                        &dstFormat)
        print("Error 3 in convertAudio: \(error.description)")

        let bufferByteSize : UInt32 = 32768
        var srcBuffer = [UInt8](repeating: 0, count: 32768)
        var sourceFrameOffset : ULONG = 0

        while(true){
            var fillBufList = AudioBufferList(
                mNumberBuffers: 1,
                mBuffers: AudioBuffer(
                    mNumberChannels: 2,
                    mDataByteSize: UInt32(srcBuffer.count),
                    mData: &srcBuffer
                )
            )
            var numFrames : UInt32 = 0

            if(dstFormat.mBytesPerFrame > 0){
                numFrames = bufferByteSize / dstFormat.mBytesPerFrame
            }

            error = ExtAudioFileRead(sourceFile!, &numFrames, &fillBufList)
            print("Error 4 in convertAudio: \(error.description)")

            if(numFrames == 0){
                error = noErr;
                break;
            }

            sourceFrameOffset += numFrames
            error = ExtAudioFileWrite(destinationFile!, numFrames, &fillBufList)
            print("Error 5 in convertAudio: \(error.description)")
        }

        error = ExtAudioFileDispose(destinationFile!)
        print("Error 6 in convertAudio: \(error.description)")
        error = ExtAudioFileDispose(sourceFile!)
        print("Error 7 in convertAudio: \(error.description)")
    }
    
}
