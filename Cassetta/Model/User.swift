//
//  User.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/17/22.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable{
    let username: String
    let email: String
    let profileImageURL: String
    let fullname: String
    
    @DocumentID var id: String?
    
    //set as an optional to conform with Decodable
    var isFollowed: Bool? = false
    
    //determines if user is the current user from shared user session
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id}
}
