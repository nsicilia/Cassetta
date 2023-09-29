//
//  AuthViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/4/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var didSendPasswordLink = false
    
    @Published var loginFail = false
    
    
    
    static let shared = AuthViewModel()
    
    
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                self.loginFail = true
                print("DEBUG: Login failed - \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            self.loginFail = false
        
        }
    }
    
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String){
            
        guard let image = image else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else { return }
                
                // Update the user's profile with the image URL
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.photoURL = URL(string: imageUrl)
                changeRequest.displayName = fullname
                
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("Error updating user profile: \(error.localizedDescription)")
                        return
                    }
                    
                    // Aggregate user information
                    let data = [
                        "email": email,
                        "username": username,
                        "fullname": fullname,
                        "profileImageURL": imageUrl,
                        "uid": user.uid
                    ]
                    
                    // Upload user data to Firestore
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                        if let error = error {
                            print("Error uploading user data: \(error.localizedDescription)")
                            return
                        }
                        
                        // Registration and data upload successful
                        self.userSession = user
                        self.fetchUser()
                    }
                }
            }
        }
    }

    
    func signout(){
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword(withEmail email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Failed to send link \(error.localizedDescription)")
            }
            self.didSendPasswordLink = true
        }
    }
    
    func fetchUser(){
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { SnapshotData, error in
            if let error = error{
                print("DEBUG: fetchUser() - \(error.localizedDescription)")
                return
            }
            
            guard let user = try? SnapshotData?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
    

    
}

