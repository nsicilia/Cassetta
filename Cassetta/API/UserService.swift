//
//  UserService.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/23/22.
//

import Firebase
import FirebaseStorage

typealias FirestoreCompletion = ((Error?) -> Void)?

struct UserService{

    
    static func follow( uid: String, completion: ((Error?) -> Void)? ){
        //get current user id
        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }
        
        //update a users following collection
        COLLECTION_FOLLOWING.document(currentUID).collection("is-following")
            .document(uid).setData([:]) { error in
                //handle, print out error
                if let error = error{ print("ERROR: Userservice func follow - \(error.localizedDescription)")}
                
                //updating the followers collection
                COLLECTION_FOLLOWERS.document(uid).collection("followed-by")
                    .document(currentUID).setData([:], completion: completion)
            }
    }
    
    
    
    static func unfollow( uid: String, completion: ((Error?) -> Void)? ){
        //get current user id
        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }
        
        //update a users following collection, remove document
        COLLECTION_FOLLOWING.document(currentUID).collection("is-following")
            .document(uid).delete { error in
                //handle, print out error
                if let error = error{ print("ERROR: Userservice func unfollow - \(error.localizedDescription)")}
                
                //updating the followers collection, remove document
                COLLECTION_FOLLOWERS.document(uid).collection("followed-by")
                    .document(currentUID).delete(completion: completion)
            }
    }
    
    
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void){
        //get current user id
        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }
        
        //Check for the existance of the document in the following collection
        COLLECTION_FOLLOWING.document(currentUID).collection("is-following")
            .document(uid).getDocument { DocumentSnapshot, Error in
                //handle error, print to console
                if let error = Error{print("ERROR: Userservice func checkIfUserIsFollowed - \(error.localizedDescription)")}
                
                //set isFollowed to a bool
                guard let isFollowed = DocumentSnapshot?.exists else { return }
                
                //set completion to bool value
                completion(isFollowed)
            }
    }
}
