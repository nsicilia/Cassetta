//
//  User.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/17/22.
//

import FirebaseFirestore

struct User: Identifiable, Decodable{
    var username: String
    let email: String
    var profileImageURL: String
    var fullname: String
    var stats: UserStats?
    var bio: String?
    var phoneNumber: String?
    
    
    @DocumentID var id: String?
    
    //set as an optional to conform with Decodable
    var isFollowed: Bool? = false
    
    //set as an optional to conform with Decodable
    var isBlocked: Bool? = false
    
    //determines if user is the current user from shared user session
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id}
    
}


struct UserStats: Decodable {
    var followers: Int
    var following: Int
    var posts: Int
}
