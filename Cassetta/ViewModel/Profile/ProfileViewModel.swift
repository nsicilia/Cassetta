//
//  ProfileViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/23/22.
//

import SwiftUI

class ProfileViewModel: ObservableObject{
    //instance of the model
    @Published var user: User
    
    init(user: User) {
        self.user = user
        //run checkIfUserIsFollowed when ProfileViewModel is created
        checkIfUserIsFollowed()
    }
    
    
    func follow(){
        //get uid of a user
        guard let uid = user.id else {return}
        
        UserService.follow(uid: uid) { error in
            //print error
            if let error = error{print("ERROR: class ProfileViewModel func follow - \(error.localizedDescription)")}
            
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
}
