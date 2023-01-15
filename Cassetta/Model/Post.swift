//
//  Post.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 1/12/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    
    let audioUrl: String
    let category: String
    let description: String
    let dislikes: Int
    let imageUrl: String
    let likes: Int
    let ownerFullname: String
    let ownerImageUrl: String
    let ownerUid: String
    let ownerUsername: String
    let timestamp: Timestamp
    let title: String
    
}
