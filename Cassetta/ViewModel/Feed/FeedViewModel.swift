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
    case category(String)
}

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var blockedByList = [User]()
    
    let config: PostFeedConfiguration
    
    init(config: PostFeedConfiguration) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    // MARK: - Fetch Posts for Configuration
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
            
        case .category(let category):
            fetchCategoryPost(forCategory: category)
            
            
        }
        
    }
    
    // MARK: - Fetch Posts
    func fetchExplorePosts(){
        // retrieve documents from COLLECTION_POSTS collection
        COLLECTION_POSTS.getDocuments { SnapshotData, error in
            //Handle error
            if let error = error{ print("ERROR: SearchViewModel - \(error.localizedDescription)"); return }
            
            // check if SnapshotData contains any documents
            guard let documents = SnapshotData?.documents else {return}
            // map the documents to Post objects using the data(as:) method and assign the result to the posts property
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
            
        }
    }
    
    
    // MARK: - Fetch User Posts
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
    
    // MARK: - Fetch Category Posts
    func fetchCategoryPost(forCategory category: String){
        COLLECTION_POSTS.whereField("category", isEqualTo: category).getDocuments { SnapshotData, error in
            //Handle error
            if let error = error{print("ERROR: SearchViewModel - \(error.localizedDescription)"); return }
            // check if SnapshotData contains any documents
            guard let documents = SnapshotData?.documents else {return}
            // map the documents to Post objects using the data(as:) method and assign the result to the posts property
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
        }
    }
    
    
    // MARK: - Fetch Newest Posts
    func fetchNewestPosts(){
        // let currentUser = AuthViewModel.shared.userSession?.uid ?? ""
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
    // MARK: - Fetch Random Posts
    func fetchPostsRandomly() {
        blockedBy {
            // let currentUser = AuthViewModel.shared.userSession?.uid ?? ""
            // retrieve documents from COLLECTION_POSTS collection
            COLLECTION_POSTS.getDocuments { SnapshotData, error in
                //Handle error
                if let error = error { print("ERROR: SearchViewModel - \(error.localizedDescription)"); return }
                
                // check if SnapshotData contains any documents
                guard let documents = SnapshotData?.documents else { return }
                // map the documents to Post objects using the data(as:) method and assign the result to the posts property
                self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
                
                //print("DEBUG: blockebByList - \(self.blockedByList)")
                self.posts = self.posts.filter { post in
                    return !self.blockedByList.contains(where: { $0.id == post.ownerUid })
                }
                
                self.posts.shuffle()
                
            }
        }
    }
    
    //MARK: - Blocked By
    func blockedBy(completion: @escaping () -> Void) {
        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_BLOCKERS.document(currentUID).collection("is-blocking").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let blockedUsers = documents.map { $0.documentID }
            
            var blockedByList = [User]()
            let dispatchGroup = DispatchGroup()
            
            for id in blockedUsers {
                dispatchGroup.enter()
                COLLECTION_USERS.document(id).getDocument { snapshot, error in
                    defer { dispatchGroup.leave() }
                    
                    guard let user = try? snapshot?.data(as: User.self) else { return }
                    blockedByList.append(user)
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.blockedByList = blockedByList
                completion()
            }
        }
    }
}
