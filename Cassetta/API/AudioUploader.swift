//
//  AudioUploader.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 1/4/23.
//

import UIKit
import Firebase
import FirebaseStorage


struct AudioUploader {
    //static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
    static func uploadAudio(audio: URL, completion: @escaping(String) -> Void){
        
        //generate unique file name string
        let filename = NSUUID().uuidString
        
        //path in firebase storage
        let ref = Storage.storage().reference(withPath: "/post_audios/\(filename)")
        
        
        
        ref.putFile(from: audio, metadata: nil) { _, error in
            //error handling
            if let error = error {
                print("DEBUG: failed to upload an audio file - \(error.localizedDescription)")
                return
            }
            
            print("DEBUG:Succsessfully uploaded audio")
            
            //get url of audio
            ref.downloadURL { url, _ in
                guard let audioURL = url?.absoluteString else {return}
                completion(audioURL)
            }
        }
        
    }
}
