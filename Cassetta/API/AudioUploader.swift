//
//  AudioUploader.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 1/4/23.
//

import UIKit
import Firebase
import FirebaseStorage
import Foundation
import SwiftUI
import Combine


class AudioUploader: NSObject, ObservableObject {
    

    @Published var progress: Double = 0
    
    //static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
    func uploadAudio(audio: URL, filename: String?, completion: @escaping(String) -> Void){
        
        //generate unique file name string
        let filename: String = filename ?? NSUUID().uuidString
        //let filename = NSUUID().uuidString
        
        //path in firebase storage
        let ref = Storage.storage().reference(withPath: "/post_audios/\(filename).m4a")
        
        
        
       let uploadTask =  ref.putFile(from: audio, metadata: nil) { _, error in
            //error handling
           if error != nil {
               // print("DEBUG: failed to upload an audio file - \(error.localizedDescription)")
                return
            }
            
           // print("DEBUG:Succsessfully uploaded audio")
            
            //get url of audio
            ref.downloadURL { url, _ in
                guard let audioURL = url?.absoluteString else {return}
                completion(audioURL)
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
                    let progress = snapshot.progress?.fractionCompleted
                    self.progress = progress ?? 0
                    //print("Progress from uploadTask: \(self.progress)")
                }
        
    }
}
