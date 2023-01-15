//
//  FeedViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 1/12/23.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]() //property that holds an array of Post objects and it is marked with @Published, which means that any changes made to the posts property will trigger an update to any views that are observing it
    
    init(){
        fetchPosts() // call fetchPosts method when an instance of the class is created
    }
    
    func fetchPosts(){
        // retrieve documents from COLLECTION_POSTS collection
        COLLECTION_POSTS.getDocuments { SnapshotData, error in
            //Handle error
            if let error = error{
                print("ERROR: SearchViewModel - \(error.localizedDescription)")
                return
            }
            // check if SnapshotData contains any documents
            guard let documents = SnapshotData?.documents else {return}
            // map the documents to Post objects using the data(as:) method and assign the result to the posts property
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
            
            print("DEBUG: self.posts", self.posts)
        }
    }
}
