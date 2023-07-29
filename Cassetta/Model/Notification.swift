//
//  Notification.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 7/2/23.
//

import FirebaseFirestoreSwift
import Firebase
import Foundation

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    var postId: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    
    var isFollowed: Bool? = false
    var post: Post?
    var user: User?
}

enum NotificationType: Int, Decodable{
    case like //raw value of 0
    case comment //raw value of 1
    case follow //raw value of 2
    
    var notificationMessage: String{
        switch self{
        case .like: return " liked your post"
        case .comment: return " commented on your post"
        case .follow: return " started following you"
        }
    }
}
