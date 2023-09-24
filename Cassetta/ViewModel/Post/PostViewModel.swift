//
//  testSOT.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/4/23.
//

import Foundation
import SwiftUI
import Firebase
import MediaPlayer

class PostViewModel: ObservableObject {
    @Published var currentPost: Post?
    
    @Published var currentPostImage: Image = Image("DefaultImage")
    
    @Published var testImage: Image?
    
    @Published var coverArtImage = UIImage(named: "DefaultImage")
    
    @Published var user: User?
    
    
    init(post: Post? = nil) {
        self.currentPost = post
        ezStatusCheck()
        getImageFromURL()
        fetchUser()
    }
    
    
    
    var likeString: String {
            return "\(Int(currentPost?.likes ?? 0).roundedWithAbbreviations)"
        }
    
        var dislikeString: String {
            return "\(Int(currentPost?.dislikes ?? 0).roundedWithAbbreviations)"
        }
    
    
    
    func like(){
        // Check if there is a user currently signed in. If not, return and do nothing.
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        
        // Get the ID of the post that is being liked.
        guard let postId = currentPost?.id else {return}
        
        // Access the "post-likes" subcollection of the post's document in the "COLLECTION_POSTS" collection.
        // Then, create a new document with the user's ID as the document ID, and an empty dictionary as the data.
        COLLECTION_POSTS.document(postId).collection("post-likes")
            .document(uid).setData([:]) { _ in
                
                // Access the "user-likes" subcollection of the user's document in the "COLLECTION_USERS" collection.
                // Then, create a new document with the post's ID as the document ID, and an empty dictionary as the data.
                COLLECTION_USERS.document(uid).collection("user-likes")
                    .document(postId).setData([:]) { _ in
                        
                        //In the firebase db add 1 to the like count
                        if let likes = self.currentPost?.likes{
                            COLLECTION_POSTS.document(postId).updateData(["likes": likes + 1])
                        }
                        
                        NotificationsViewModel.uploadNotification(toUid: self.currentPost?.ownerUid ?? "", type: .like, post: self.currentPost)
                        
                        // Update the post's "didLike" property to true, indicating that the user has liked the post.
                        self.currentPost?.didLike = true
                        //increment likes
                        self.currentPost?.likes += 1
                    }
            }
        
        undislike()
        checkIfUserDislikedPost()
    }
    
    
    func unlike(){
        guard currentPost?.likes ?? 0 > 0 else {return}
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = currentPost?.id else {return}
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
                
                if let likes = self.currentPost?.likes{
                    COLLECTION_POSTS.document(postId).updateData(["likes": likes - 1])
                }
                
                
                self.currentPost?.didLike = false
                self.currentPost?.likes -= 1
            }
        }
    }
    
    
    func dislike(){
        // Check if there is a user currently signed in. If not, return and do nothing.
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        
        // Get the ID of the post that is being disliked.
        guard let postId = currentPost?.id else {return}
        
        // Access the "post-dislikes" subcollection of the post's document in the "COLLECTION_POSTS" collection.
        // Then, create a new document with the user's ID as the document ID, and an empty dictionary as the data.
        COLLECTION_POSTS.document(postId).collection("post-dislikes")
            .document(uid).setData([:]) { _ in
                
                // Access the "user-dislikes" subcollection of the user's document in the "COLLECTION_USERS" collection.
                // Then, create a new document with the post's ID as the document ID, and an empty dictionary as the data.
                COLLECTION_USERS.document(uid).collection("user-dislikes")
                    .document(postId).setData([:]) { _ in
                        
                        //In the firebase db add 1 to the dislike count
                        if let dislikes = self.currentPost?.dislikes{
                            COLLECTION_POSTS.document(postId).updateData(["dislikes": dislikes + 1])
                        }
                        // Update the post's "didDislike" property to true, indicating that the user has disliked the post.
                        self.currentPost?.didDislike = true
                        //increment dislikes
                        self.currentPost?.dislikes += 1
                    }
            }
        unlike()
        checkIfUserLikedPost()
    }
    
    
    
    func undislike(){
        guard currentPost?.dislikes ?? 0 > 0 else {return}
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = currentPost?.id else {return}
        
        COLLECTION_POSTS.document(postId).collection("post-dislikes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-dislikes").document(postId).delete { _ in
                
                if let dislikes = self.currentPost?.dislikes{
                    COLLECTION_POSTS.document(postId).updateData(["dislikes": dislikes - 1])
                }
                
                self.currentPost?.didDislike = false
                self.currentPost?.dislikes -= 1
            }
        }
    }
    
    
    
    func checkIfUserLikedPost(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = currentPost?.id else {return}
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(postId).getDocument { snapshot, _ in
            guard let didlike = snapshot?.exists else {return}
            self.currentPost?.didLike = didlike
        }
    }
    
    
    
    func checkIfUserDislikedPost(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = currentPost?.id else {return}
        
        COLLECTION_USERS.document(uid).collection("user-dislikes").document(postId).getDocument { snapshot, _ in
            guard let didDislike = snapshot?.exists else {return}
            self.currentPost?.didDislike = didDislike
        }
        
    }
    
    func ezStatusCheck(){
        checkIfUserLikedPost()
        checkIfUserDislikedPost()
        
    }


    func getImageFromURL() {
      //  print("Debug: func working")
        guard let url = URL(string: currentPost?.imageUrl ?? "") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
        
            guard let data = data, error == nil else {
            //    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
          
            DispatchQueue.main.async {
                if let image = UIImage(data: data)?.resized(to: CGSize(width: 200, height: 200), contentMode: .scaleAspectFill, clipsToBounds: true) {
                    self.testImage = Image(uiImage: image)
                    self.coverArtImage = image
                  
                    
                    var mediaInfo = [String:Any]()
                    // Convert UIImage to MPMediaItemArtwork
                    let artwork = MPMediaItemArtwork(boundsSize: image.size) { _ in
                        return image
                    }
                    mediaInfo[MPMediaItemPropertyArtwork] = artwork
                    mediaInfo[MPMediaItemPropertyTitle] = self.currentPost?.title
                    mediaInfo[MPMediaItemPropertyArtist] = self.currentPost?.ownerUsername
                    mediaInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0.0
                    mediaInfo[MPMediaItemPropertyPlaybackDuration] = self.currentPost?.duration
                    
                    MPNowPlayingInfoCenter.default().nowPlayingInfo = mediaInfo
                }
            }
        }.resume()
        
    }

    
    
    func fetchUser(){
        guard let uid = currentPost?.ownerUid else { return }
        
      //  print("Debug: fetchUser uid - \(uid)")
        
        COLLECTION_USERS.document(uid).getDocument { SnapshotData, error in
            if let error = error{
              //  print("DEBUG: fetchUser() - \(error.localizedDescription)")
                return
            }
            
            
            guard let user = try? SnapshotData?.data(as: User.self) else { return }
            
            print("Debug: fetchUser user - \(user)")
            
            self.user = user
        }
    }
    
    
}

