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
    var dislikes: Int
    let imageUrl: String
    var likes: Int
    let ownerFullname: String
    let ownerImageUrl: String
    let ownerUid: String
    let ownerUsername: String
    let timestamp: Timestamp
    let title: String
    let duration: Double
    var listens: Int
    
    var didLike: Bool? = false
    var didDislike: Bool? = false
}
