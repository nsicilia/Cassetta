//
//  User.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/17/22.
//

import FirebaseFirestoreSwift

struct User: Decodable{
    let username: String
    let email: String
    let profileImageURL: String
    let fullname: String
    
    @DocumentID var id: String?
}
