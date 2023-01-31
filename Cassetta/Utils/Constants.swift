//
//  Constants.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/17/22.
//

import Firebase
import FirebaseFirestore

///Access firestore collection "users"
let COLLECTION_USERS = Firestore.firestore().collection("users")
///Access firestore collection "followers"
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
///Access firestore collection "following"
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
///Access firestore collection "posts"
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
