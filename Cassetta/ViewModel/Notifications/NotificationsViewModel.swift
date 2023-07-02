//
//  NotificationsViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 7/2/23.
//

import SwiftUI
import Firebase

class NotificationsViewModel: ObservableObject{
    @Published var notifications = [Notification]()
    
    init(){
        fetchNotifications()
    }
    
    
    func fetchNotifications(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.notifications = documents.compactMap({ try? $0.data(as: Notification.self) })
            
            print(self.notifications)
        }
    }
    
    
    static func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil){
        guard let user = AuthViewModel.shared.currentUser else {return}
        
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "uid": user.id ?? "",
                                   "profileImageUrl": user.profileImageURL,
                                   "type": type.rawValue,
                                   ]
        
        if let post = post, let id = post.id{
            data["postId"] = id
        }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").addDocument(data: data)
    }
}
