//
//  EditProfileViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/2/23.
//

import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    var user: User
    @Published var uploadComplete = false
    @Published var userSessionProfilePhoto = AuthViewModel.shared.userSession?.photoURL


    
    init(user: User) {
        self.user = user
    }
    
    private var uploadTasksCount = 0 {
            didSet {
                if uploadTasksCount == 3 {
                   uploadComplete = true
                }
            }
        }
    

    
    func saveUserBio(_ bio: String) {
        guard let uid = user.id else { return }
        
        if (user.bio == bio) {
            uploadTasksCount += 1
            return
        }
        
        COLLECTION_USERS.document(uid).updateData(["bio": bio]) { _ in
            self.user.bio = bio
            //self.uploadComplete = true
            self.uploadTasksCount += 1
            print("DEBUG: uploadComplete bio: \(self.uploadComplete)")
            
            
        }
    }
    
    func saveUserFullname(_ fullname: String) {
        
        guard let uid = user.id else { return }
        
        if (user.fullname == fullname) {
            uploadTasksCount += 1
            return
        }
        
        
        COLLECTION_USERS.document(uid).updateData(["fullname": fullname]) { _ in
            
          //  print("DEBUG: fullname: \(fullname)")
            self.user.fullname = fullname
            //self.uploadComplete = true
            self.uploadTasksCount += 1
            
            print("DEBUG: uploadComplete fullname: \(self.uploadComplete)")
        }
        
    }
    
    func updateProfilePhoto(newImage: UIImage?) {
        guard let uid = user.id else { return }
        guard let currentUser = Auth.auth().currentUser else { return }
        
        guard let newImage = newImage else { return }
        
        // Upload the new image to Firebase Storage
        ImageUploader.uploadImage(image: newImage, type: .profile) { imageUrl in
            // Update the user's profile with the new photo URL
            let changeRequest = currentUser.createProfileChangeRequest()
            changeRequest.photoURL = URL(string: imageUrl)
            
            changeRequest.commitChanges { error in
                if error != nil { return }
                

                COLLECTION_USERS.document(uid).updateData(["profileImageURL": imageUrl]) { _ in
                    self.user.profileImageURL = imageUrl
                    //self.uploadComplete = true
                    self.uploadTasksCount += 1
                    
                }
            }
        }
    }
    
    
    
}
