//
//  UploadPostViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 1/4/23.
//

import SwiftUI
import Firebase


class UploadPostViewModel: ObservableObject {
    
    func uploadPost(title: String, description: String, category: String, image:UIImage, audio: URL, completion: FirestoreCompletion){
        //get info about current user
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        ImageUploader.uploadImage(image: image, type: .post) { imageURL in
            
            
            AudioUploader.uploadAudio(audio: audio) { audioURL in
                
                let data = ["title": title,
                            "description": description,
                            "cagegory": category,
                            "timestamp": Timestamp(date: Date()),
                            "likes": 0,
                            "imageUrl": imageURL,
                            "audioURL": audioURL,
                            "ownerUid": user.id ?? "",
                            "ownerImageUrl": user.profileImageURL,
                            "ownerUsername": user.username] as [String: Any]
                
                COLLECTION_POSTS.addDocument(data: data, completion: completion)
                
//                COLLECTION_POSTS.addDocument(data: data) { error in
//                    //Handle error
//                    if let error = error{
//                        print("DEBUG: UploadPostViewModel failed - \(error.localizedDescription)")
//                        return
//                    }
//
//                    print("DEBUG: Post Uploaded")
//
//                }
                
            }//AudioUploader
        }//ImageUploader
        
    }
}
