//
//  UploadPostViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 1/4/23.
//

import SwiftUI
import Firebase
import Combine

class UploadPostViewModel: ObservableObject {
    @Published var audioProgress: Double = 0
    private var audioUploadCancellable: Cancellable?

    func uploadPost(title: String, description: String, category: String, image:UIImage, audio: URL, duration: Double, completion: FirestoreCompletion){
        //get info about current user
        guard let user = AuthViewModel.shared.currentUser else { return }
        //get timestamp for post
        let postTimeStamp = Timestamp(date: Date())
        //generate unique document ID
        let docID = NSUUID().uuidString

        ImageUploader.uploadImage(image: image, type: .post) { imageURL in
            
            let audioUploader = AudioUploader()
            self.audioUploadCancellable = audioUploader.$progress.sink { self.audioProgress = $0 }
            
            audioUploader.uploadAudio(audio: audio, filename: docID) { audioURL in
                
                let data = ["title": title,
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
                            "ownerUsername": user.username] as [String: Any]
                
                COLLECTION_POSTS.document(docID).setData(data, completion: completion)
                
            }//AudioUploader
        }//ImageUploader
        
    }
}
