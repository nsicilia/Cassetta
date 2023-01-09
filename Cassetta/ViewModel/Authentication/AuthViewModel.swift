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
    
    static let shared = AuthViewModel()
    
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                print("DEBUG: Login failed - \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String){
        
        guard let image = image else {return}
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else { return }
                
                print("DEBUG:Succsessfully registered user")
                print("DEBUG: uid \(user.uid)")
                
                //agrigate user infomration
                let data = ["email": email,
                            "username": username,
                            "fullname": fullname,
                            "profileImageURL": imageUrl,
                            "uid": user.uid]
                
                //Upload
                Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                    print("DEBUG:Succsessfully uploaded user data")
                    self.userSession = user
                    self.fetchUser()
                }
                
            }
        }
        
    }
    
    func signout(){
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword(){
        
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

