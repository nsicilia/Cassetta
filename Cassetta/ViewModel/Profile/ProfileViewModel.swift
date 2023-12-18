//
//  ProfileViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/23/22.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject{
    //instance of the model
    @Published var user: User
   
    
    
    
    init(user: User) {
        self.user = user
        //run checkIfUserIsFollowed when ProfileViewModel is created
        checkIfUserIsFollowed()
        fetchUserStats()
        fetchUserBio()
        fetchUserFullname()
        fetchUserPhotoURL()
        checkIfUserIsBlocked()
    }
    
    
    func follow(){
        //get uid of a user
        guard let uid = user.id else {return}
                
        UserService.follow(uid: uid) { error in
            //print error
            if let error = error{print("ERROR: class ProfileViewModel func follow - \(error.localizedDescription)")}
            
            NotificationsViewModel.uploadNotification(toUid: uid, type: .follow)
            
            //update bool in User model
            self.user.isFollowed = true
        }
    }
    
    
    
    func unfollow(){
        //get uid of a user
        guard let uid = user.id else { return }
        
        UserService.unfollow(uid: uid) { error in
            //print error
            if let error = error{print("ERROR: class ProfileViewModel func unfollow - \(error.localizedDescription)")}
            
            //update bool in User model
            self.user.isFollowed = false
        }
    }
    
    
    
    func checkIfUserIsFollowed(){
        //don't make an api call if its the current user
        guard !user.isCurrentUser else { return }
        //get uid if a user
        guard let uid = user.id else { return }
        //check if currentUser is following user
        UserService.checkIfUserIsFollowed(uid: uid) { isFollowed in
            //set a user value to result
            self.user.isFollowed = isFollowed
        }
    }
    
    
    func fetchUserStats(){
        guard let uid = user.id else { return }
        
        COLLECTION_FOLLOWING.document(uid).collection("is-following").getDocuments { snapshot, _ in
            guard let following = snapshot?.documents.count else { return }
            
            COLLECTION_FOLLOWERS.document(uid).collection("followed-by").getDocuments { snapshot, _ in
                guard let followers = snapshot?.documents.count else { return }
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
                    guard let posts = snapshot?.documents.count else { return }
                    
                    self.user.stats = UserStats(followers: followers, following: following, posts: posts)
                    //print("DEBUG: class ProfileViewModel func fetchUserStats - \(self.user.stats)")
                }
            }
        
        }
    }
    
    func fetchUserBio() {
            guard let uid = user.id else { return }
            
            // Replace 'COLLECTION_USERS' with your actual database collection for users
            COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("ERROR: ProfileViewModel fetchUserBio - \(error.localizedDescription)")
                    return
                }

                if let data = snapshot?.data(),
                   let bio = data["bio"] as? String {
                    self.user.bio = bio
                }
            }
        }
    
    func fetchUserFullname() {
            guard let uid = user.id else { return }
            
            // Replace 'COLLECTION_USERS' with your actual database collection for users
            COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("ERROR: ProfileViewModel fetchUserBio - \(error.localizedDescription)")
                    return
                }
                if let data = snapshot?.data(),
                   let fullname = data["fullname"] as? String {
                    self.user.fullname = fullname
                }
            }
        
        }
    

    func fetchUserPhotoURL() {
        guard let uid = user.id else { return }

        // Replace 'COLLECTION_USERS' with your actual database collection for users
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let error = error {
                print("ERROR: ProfileViewModel fetchUserPhotoURL - \(error.localizedDescription)")
                return
            }

            if let data = snapshot?.data(),
               let photoURL = data["profileImageURL"] as? String {
                self.user.profileImageURL = photoURL
            }
        }
    }
    
    
    func block(){
        print("DEBUG: ProfileViewModel func block - \(String(describing: user.id))")
        //get uid of a user
        guard let uid = user.id else {return}
                
        UserService.blockUser(uid: uid) { error in
            //print error
            if let error = error{print("ERROR: class ProfileViewModel func follow - \(error.localizedDescription)")}
            
            //update bool in User model
            self.user.isBlocked = true
            print("DEBUG: ProfileViewModel func block - \(String(describing: self.user.isBlocked))")
        }
    }
    
    
    func unblock(){
        //get uid of a user
        guard let uid = user.id else { return }
        
        UserService.unblockUser(uid: uid) { error in
            //print error
            if let error = error{print("ERROR: class ProfileViewModel func unfollow - \(error.localizedDescription)")}
            
            //update bool in User model
            self.user.isBlocked = false
        }
    }
    
    func checkIfUserIsBlocked(){
        //don't make an api call if its the current user
        guard !user.isCurrentUser else { return }
        //get uid if a user
        guard let uid = user.id else { return }
        //check if currentUser is following user
        UserService.checkIfUserIsBlocked(uid: uid) { isBlocked in
            //set a user value to result
            self.user.isBlocked = isBlocked
        }
    }

    }
