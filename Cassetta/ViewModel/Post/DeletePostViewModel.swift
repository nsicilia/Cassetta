//
//  DeletePostViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/29/23.
//

import SwiftUI
import Firebase
import Combine

class DeletePostViewModel: ObservableObject {

    func deletePost(post: Post, completion: FirestoreCompletion?) {
        // Ensure there's a user logged in
        guard let user = AuthViewModel.shared.currentUser else { return }

        guard let postId = post.id else { return }

        // Reference to the post document you want to delete
        let postRef = COLLECTION_POSTS.document(postId)

        // Check if the current user is the owner of the post before deleting
        if user.id == post.ownerUid {
            // Delete the post document
            postRef.delete { error in
                if let error = error {
                    print("Error deleting post: \(error.localizedDescription)")
                } else {
                    print("Post deleted successfully")
                    // You can perform any additional actions or updates here after successful deletion
                }
                //completion?(error)
            }
        } else {
            // Handle the case where the current user is not the owner of the post
            print("User does not have permission to delete this post")
            // You can display an error message or perform any other necessary actions
            //completion?(nil) // Pass nil to indicate no error
        }
    }
}
