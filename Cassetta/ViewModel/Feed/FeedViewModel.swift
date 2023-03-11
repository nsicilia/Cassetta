//
//  FeedViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 1/12/23.
//

import SwiftUI

enum PostFeedConfiguration{
    case explore
    case newest
    case random
    case profile(String)
}

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    let config: PostFeedConfiguration
    
    init(config: PostFeedConfiguration) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    
    func fetchPosts(forConfig config: PostFeedConfiguration){
        switch config {
        case .explore:
            fetchExplorePosts()
            
        case .newest:
            fetchNewestPosts()
            
        case .random:
            fetchPostsRandomly()
            
        case .profile(let uid):
            fetchUserPosts(forUid: uid)
        }
    }
    
    
    func fetchExplorePosts(){
        // retrieve documents from COLLECTION_POSTS collection
        COLLECTION_POSTS.getDocuments { SnapshotData, error in
            //Handle error
            if let error = error{ print("ERROR: SearchViewModel - \(error.localizedDescription)"); return }
            
            // check if SnapshotData contains any documents
            guard let documents = SnapshotData?.documents else {return}
            // map the documents to Post objects using the data(as:) method and assign the result to the posts property
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
            
           // print("DEBUG: self.posts", self.posts)
        }
    }
    
    func fetchUserPosts(forUid uid: String){
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { SnapshotData, error in
            //Handle error
            if let error = error{print("ERROR: SearchViewModel - \(error.localizedDescription)"); return }
            // check if SnapshotData contains any documents
            guard let documents = SnapshotData?.documents else {return}
            // map the documents to Post objects using the data(as:) method and assign the result to the posts property
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
        }
    }
    
    
    func fetchNewestPosts(){
        // retrieve documents from COLLECTION_POSTS collection
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { SnapshotData, error in
            //Handle error
            if let error = error{ print("ERROR: SearchViewModel - \(error.localizedDescription)"); return }
            
            // check if SnapshotData contains any documents
            guard let documents = SnapshotData?.documents else {return}
            // map the documents to Post objects using the data(as:) method and assign the result to the posts property
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
            
           // print("DEBUG: self.posts", self.posts)
        }
    }
    
    
    func fetchPostsRandomly(){
        // retrieve documents from COLLECTION_POSTS collection
        COLLECTION_POSTS.getDocuments { SnapshotData, error in
            //Handle error
            if let error = error{ print("ERROR: SearchViewModel - \(error.localizedDescription)"); return }
            
            // check if SnapshotData contains any documents
            guard let documents = SnapshotData?.documents else {return}
            // map the documents to Post objects using the data(as:) method and assign the result to the posts property
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
            
            self.posts.shuffle()
        }
    }
    
    
}
