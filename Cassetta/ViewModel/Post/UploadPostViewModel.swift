//
//  UploadPostViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 1/4/23.
//

import SwiftUI
import Firebase
import Combine
import AVFoundation

class UploadPostViewModel: ObservableObject {
    @Published var audioProgress: Double = 0
    private var audioUploadCancellable: Cancellable?

    func uploadPost(title: String,
                    description: String,
                    category: String,
                    image: UIImage,
                    audio: URL,
                    duration: Double,
                    completion: FirestoreCompletion) {
        
        guard let user = AuthViewModel.shared.currentUser else { return }
        let postTimeStamp = Timestamp(date: Date())
        let docID = NSUUID().uuidString
        
        ImageUploader.uploadImage(image: image, type: .post) { imageURL in
            
            self.convertToAAC_ADTS(inputURL: audio, outputFileName: "\(docID).aac") { aacURL in
                guard let aacURL = aacURL else {
                    print("AAC conversion failed.")
                    return
                }

                let audioUploader = AudioUploader()
                self.audioUploadCancellable = audioUploader.$progress.sink { self.audioProgress = $0 }

                audioUploader.uploadAudio(audio: aacURL, filename: docID) { audioURL in
                    let data: [String: Any] = [
                        "title": title,
                        "description": description,
                        "category": category,
                        "timestamp": postTimeStamp,
                        "likes": 0,
                        "listens": 0,
                        "duration": duration,
                        "dislikes": 0,
                        "imageUrl": imageURL,
                        "audioUrl": audioURL,
                        "ownerUid": user.id ?? "",
                        "ownerImageUrl": user.profileImageURL,
                        "ownerFullname": user.fullname,
                        "ownerUsername": user.username
                    ]

                    COLLECTION_POSTS.document(docID).setData(data, completion: completion)
                }
            }
        }
    }

    func convertToAAC_ADTS(inputURL: URL, outputFileName: String, completion: @escaping (URL?) -> Void) {
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent(outputFileName)
        
        guard let inputFile = try? AVAudioFile(forReading: inputURL) else {
            completion(nil)
            return
        }

        let format = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                    sampleRate: inputFile.fileFormat.sampleRate,
                                    channels: inputFile.fileFormat.channelCount,
                                    interleaved: false)!

        let outputFormat = AVAudioFormat(settings: [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: inputFile.fileFormat.sampleRate,
            AVNumberOfChannelsKey: inputFile.fileFormat.channelCount,
            AVEncoderBitRateKey: 192_000
        ])!

        guard let outputFile = try? AVAudioFile(forWriting: outputURL, settings: outputFormat.settings, commonFormat: .pcmFormatFloat32, interleaved: false) else {
            completion(nil)
            return
        }

        let bufferCapacity = 1024
        guard let buffer = AVAudioPCMBuffer(pcmFormat: inputFile.processingFormat, frameCapacity: AVAudioFrameCount(bufferCapacity)) else {
            completion(nil)
            return
        }

        do {
            while inputFile.framePosition < inputFile.length {
                try inputFile.read(into: buffer)
                try outputFile.write(from: buffer)
            }
            completion(outputURL)
        } catch {
            print("Error during AAC conversion: \(error)")
            completion(nil)
        }
    }
}
