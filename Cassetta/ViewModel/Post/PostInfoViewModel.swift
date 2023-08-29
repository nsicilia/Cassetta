//
//  PostInfoViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 2/24/23.
//

import SwiftUI

class PostInfoViewModel: ObservableObject{
    @Published var post: Post
    
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
        checkIfUserDislikedPost()
    }
    
    var likeString: String {
        return "\(Int(post.likes).roundedWithAbbreviations)"
    }
    
    var dislikeString: String {
        return "\(Int(post.dislikes).roundedWithAbbreviations)"
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    
    
    func like(){
        // Check if there is a user currently signed in. If not, return and do nothing.
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        
        // Get the ID of the post that is being liked.
        guard let postId = post.id else {return}
        
        // Access the "post-likes" subcollection of the post's document in the "COLLECTION_POSTS" collection.
        // Then, create a new document with the user's ID as the document ID, and an empty dictionary as the data.
        COLLECTION_POSTS.document(postId).collection("post-likes")
            .document(uid).setData([:]) { _ in
                
                // Access the "user-likes" subcollection of the user's document in the "COLLECTION_USERS" collection.
                // Then, create a new document with the post's ID as the document ID, and an empty dictionary as the data.
                COLLECTION_USERS.document(uid).collection("user-likes")
                    .document(postId).setData([:]) { _ in
                        
                        //In the firebase db add 1 to the like count
                        COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes + 1])
                        
                        // Update the post's "didLike" property to true, indicating that the user has liked the post.
                        self.post.didLike = true
                        //increment likes
                        self.post.likes += 1
                    }
            }
        
        undislike()
    }
    
    
    func unlike(){
        guard post.likes > 0 else {return}
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
                COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes - 1])
                
                self.post.didLike = false
                self.post.likes -= 1
            }
        }
        
        
    }
    
    
    func dislike(){
        // Check if there is a user currently signed in. If not, return and do nothing.
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        
        // Get the ID of the post that is being disliked.
        guard let postId = post.id else {return}
        
        // Access the "post-dislikes" subcollection of the post's document in the "COLLECTION_POSTS" collection.
        // Then, create a new document with the user's ID as the document ID, and an empty dictionary as the data.
        COLLECTION_POSTS.document(postId).collection("post-dislikes")
            .document(uid).setData([:]) { _ in
                
                // Access the "user-dislikes" subcollection of the user's document in the "COLLECTION_USERS" collection.
                // Then, create a new document with the post's ID as the document ID, and an empty dictionary as the data.
                COLLECTION_USERS.document(uid).collection("user-dislikes")
                    .document(postId).setData([:]) { _ in
                        
                        //In the firebase db add 1 to the dislike count
                        COLLECTION_POSTS.document(postId).updateData(["dislikes": self.post.dislikes + 1])
                        
                        // Update the post's "didDislike" property to true, indicating that the user has disliked the post.
                        self.post.didDislike = true
                        //increment dislikes
                        self.post.dislikes += 1
                    }
            }
        unlike()
    }
    
    
    func undislike(){
        guard post.dislikes > 0 else {return}
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        COLLECTION_POSTS.document(postId).collection("post-dislikes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-dislikes").document(postId).delete { _ in
                COLLECTION_POSTS.document(postId).updateData(["dislikes": self.post.dislikes - 1])
                
                self.post.didDislike = false
                self.post.dislikes -= 1
            }
        }
    }
    
    
    func checkIfUserLikedPost(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(postId).getDocument { snapshot, _ in
            guard let didlike = snapshot?.exists else {return}
            self.post.didLike = didlike
        }
        
    }
    
    
    func checkIfUserDislikedPost(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        COLLECTION_USERS.document(uid).collection("user-dislikes").document(postId).getDocument { snapshot, _ in
            guard let didDislike = snapshot?.exists else {return}
            self.post.didDislike = didDislike
        }
        
    }
    
    
}
