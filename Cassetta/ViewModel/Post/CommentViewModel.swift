//
//  CommentViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 4/15/23.
//

import SwiftUI
import Firebase

// Define a class named CommentViewModel that conforms to the ObservableObject protocol
class CommentViewModel: ObservableObject{
    
    // Define a private property to store the Post object
    private let post: Post
    
    // Define a published property to store an array of Comment objects
    @Published var comments = [Comment]()
    
    // Define an initializer that takes a Post object and fetches its comments
    init(post: Post) {
        self.post = post
        fetchComments()
    }
    
    // Define a method to upload a new comment to the database
    func uploadComment(commentText: String){
        // Check if a user is authenticated
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        // Check if the post ID exists
        guard let postId = post.id else { return }
        
        // Define a dictionary to store the comment data
        let data: [String : Any]  = [
            "username": user.username,
            "profileImageUrl": user.profileImageURL,
            "uid": user.id ?? "",
            "timestamp": Timestamp(date: Date()),
            "postOwnerUid": post.ownerUid,
            "commentText": commentText
        ]
        
        // Add the comment data to the "post-comments" subcollection of the "posts" collection in Firestore
        COLLECTION_POSTS.document(postId).collection("post-comments").addDocument(data: data) { error in
            if let error = error{
                print("DEBUG: Error uploading comment \(error.localizedDescription)")
            }
            
            NotificationsViewModel.uploadNotification(toUid: self.post.ownerUid, type: .comment, post: self.post)
        }
    }
    
    // Define a method to fetch all comments related to the post
    func fetchComments(){
        // Check if the post ID exists
        guard let postId = post.id else { return }
        
        // Define a Firestore query to fetch all comments related to the post
        let query = COLLECTION_POSTS.document(postId).collection("post-comments").order(by: "timestamp", descending: true)
        
        // Listen for any changes in the query and update the comments array
        query.addSnapshotListener { snapshot, _ in
            // Filter the added documents from the snapshot
            guard let addDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else {return}
            // Extract the Comment objects from the added documents and add them to the comments array
            self.comments.append(contentsOf: addDocs.compactMap({ try? $0.document.data(as: Comment.self) }))
            
            // Alternatively, we could use a forEach loop to extract the Comment objects from the added documents:
//            snapshot?.documentChanges.forEach({ change in
//                if change.type == .added {
//                    guard let comment = try? change.document.data(as: Comment.self) else {return}
//                    self.comments.append(comment)
//                }
//            })
        }
    }
}
