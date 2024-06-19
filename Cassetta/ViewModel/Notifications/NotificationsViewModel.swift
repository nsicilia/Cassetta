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
    
    
    func fetchNotifications() {
        // Ensure the user is logged in and has a valid user ID
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        // Construct the Firestore query to fetch user notifications,
        // ordered by timestamp in descending order (most recent first)
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").order(by: "timestamp", descending: true)
        
        // Execute the query to get the documents
        query.getDocuments { snapshot, _ in
            // Ensure the snapshot contains documents
            guard let documents = snapshot?.documents else { return }
            
            // Map the documents to Notification objects, ignoring any that fail to convert
            self.notifications = documents.compactMap { try? $0.data(as: Notification.self) }
            
            // Debugging: Print the fetched notifications (commented out)
            // print("DEBUG: Notifications - \(self.notifications)")
        }
    }

    
    
    static func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil){
        guard let user = AuthViewModel.shared.currentUser else {return}
        guard uid != user.id else {return}
        
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
