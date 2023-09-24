//
//  NotificationCellViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 7/22/23.
//

import SwiftUI

class NotificationCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(notification: Notification){
        self.notification = notification
        checkIfUserIsFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    
    func follow(){
        UserService.follow(uid: notification.uid) { error in
            
            if let error = error{
                print("ERROR: class ProfileViewModel func follow - \(error.localizedDescription)")
            }
            
            NotificationsViewModel.uploadNotification(toUid: self.notification.uid, type: .follow)
            
            self.notification.isFollowed = true
        }
    }
    
    func unfollow(){
        UserService.unfollow(uid: notification.uid) { error in
            
            if let error = error{
                print("ERROR: class ProfileViewModel func unfollow - \(error.localizedDescription)")
            }
            
            self.notification.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed(){
        //guard !user.isCurrentUser else { return }
        guard notification.type == .follow else {return}
        UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowd in
            self.notification.isFollowed = isFollowd
        }
        
    }
    
    
    func fetchNotificationPost(){
        guard let postId = notification.postId else { return }
        
        COLLECTION_POSTS.document(postId).getDocument { SnapshotData, _ in
            self.notification.post = try? SnapshotData?.data(as: Post.self)
        }
    }
    
    
    func fetchNotificationUser(){
        COLLECTION_USERS.document(notification.uid).getDocument { snapshot, _ in
            self.notification.user = try? snapshot?.data(as: User.self)
           
        }
    }
    
}
