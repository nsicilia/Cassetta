//
//  testSOT.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/4/23.
//

import Foundation
import SwiftUI
import Firebase

class PostViewModel: ObservableObject {
    @Published var playingPost: Post?
    
    
    
    init(post: Post? = nil) {
        self.playingPost = post
        checkIfUserLikedPost()
        checkIfUserDislikedPost()
    }
    
    
    
    var likeString: String {
            return "\(Int(playingPost?.likes ?? 0).roundedWithAbbreviations)"
        }
    
        var dislikeString: String {
            return "\(Int(playingPost?.dislikes ?? 0).roundedWithAbbreviations)"
        }
    
    
    
    func like(){
        // Check if there is a user currently signed in. If not, return and do nothing.
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        
        // Get the ID of the post that is being liked.
        guard let postId = playingPost?.id else {return}
        
        // Access the "post-likes" subcollection of the post's document in the "COLLECTION_POSTS" collection.
        // Then, create a new document with the user's ID as the document ID, and an empty dictionary as the data.
        COLLECTION_POSTS.document(postId).collection("post-likes")
            .document(uid).setData([:]) { _ in
                
                // Access the "user-likes" subcollection of the user's document in the "COLLECTION_USERS" collection.
                // Then, create a new document with the post's ID as the document ID, and an empty dictionary as the data.
                COLLECTION_USERS.document(uid).collection("user-likes")
                    .document(postId).setData([:]) { _ in
                        
                        //In the firebase db add 1 to the like count
                        if let likes = self.playingPost?.likes{
                            COLLECTION_POSTS.document(postId).updateData(["likes": likes + 1])
                        }
                        // Update the post's "didLike" property to true, indicating that the user has liked the post.
                        self.playingPost?.didLike = true
                        //increment likes
                        self.playingPost?.likes += 1
                    }
            }
        
        //undislike()
    }
    
    
    func unlike(){
        guard playingPost?.likes ?? 0 > 0 else {return}
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = playingPost?.id else {return}
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
                
                if let likes = self.playingPost?.likes{
                    COLLECTION_POSTS.document(postId).updateData(["likes": likes - 1])
                }
                
                
                self.playingPost?.didLike = false
                self.playingPost?.likes -= 1
            }
        }
    }
    
    
    func dislike(){
        // Check if there is a user currently signed in. If not, return and do nothing.
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        
        // Get the ID of the post that is being disliked.
        guard let postId = playingPost?.id else {return}
        
        // Access the "post-dislikes" subcollection of the post's document in the "COLLECTION_POSTS" collection.
        // Then, create a new document with the user's ID as the document ID, and an empty dictionary as the data.
        COLLECTION_POSTS.document(postId).collection("post-dislikes")
            .document(uid).setData([:]) { _ in
                
                // Access the "user-dislikes" subcollection of the user's document in the "COLLECTION_USERS" collection.
                // Then, create a new document with the post's ID as the document ID, and an empty dictionary as the data.
                COLLECTION_USERS.document(uid).collection("user-dislikes")
                    .document(postId).setData([:]) { _ in
                        
                        //In the firebase db add 1 to the dislike count
                        if let dislikes = self.playingPost?.dislikes{
                            COLLECTION_POSTS.document(postId).updateData(["dislikes": dislikes + 1])
                        }
                        // Update the post's "didDislike" property to true, indicating that the user has disliked the post.
                        self.playingPost?.didDislike = true
                        //increment dislikes
                        self.playingPost?.dislikes += 1
                    }
            }
        unlike()
    }
    
    
    
    func undislike(){
        guard playingPost?.dislikes ?? 0 > 0 else {return}
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = playingPost?.id else {return}
        
        COLLECTION_POSTS.document(postId).collection("post-dislikes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-dislikes").document(postId).delete { _ in
                
                if let dislikes = self.playingPost?.dislikes{
                    COLLECTION_POSTS.document(postId).updateData(["dislikes": dislikes - 1])
                }
                
                self.playingPost?.didDislike = false
                self.playingPost?.dislikes -= 1
            }
        }
    }
    
    
    func checkIfUserLikedPost(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = playingPost?.id else {return}
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(postId).getDocument { snapshot, _ in
            guard let didlike = snapshot?.exists else {return}
            self.playingPost?.didLike = didlike
        }
    }
    
    
    
    func checkIfUserDislikedPost(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = playingPost?.id else {return}
        
        COLLECTION_USERS.document(uid).collection("user-dislikes").document(postId).getDocument { snapshot, _ in
            guard let didDislike = snapshot?.exists else {return}
            self.playingPost?.didDislike = didDislike
        }
        
    }
    
}
