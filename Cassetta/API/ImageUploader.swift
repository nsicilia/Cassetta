//
//  ImageUploader.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/14/22.
//

import UIKit
import Firebase
import FirebaseStorage


enum UploadType {
    case profile
    case post
    
    var filePath: StorageReference{
        //generate unique file name string
        let filename = NSUUID().uuidString
        
        switch self{
        case .profile:
            return Storage.storage().reference(withPath: "/profile_images/\(filename)")
        case .post:
            return Storage.storage().reference(withPath: "/post_images/\(filename)")
        }
    }
    
}



struct ImageUploader {
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String) -> Void){
        //compress the image to 50%
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        
        //path in firebase storage
        let ref = type.filePath
        
        //upload the photo
        ref.putData(imageData, metadata: nil) { _ , error in
            //error handling
            if let error = error {
                //print("DEBUG: failed to upload an image - \(error.localizedDescription)")
                return
            }
            
            //print("DEBUG:Succsessfully uploaded image")
            
            //get url of photo
            ref.downloadURL { url, _ in
                guard let imageURL = url?.absoluteString else {return}
                completion(imageURL)
            }
        }
        
    }
}
