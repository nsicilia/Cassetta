//
//  SearchViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/19/22.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    @Published var blockedByList = [User]()
    
    init(){
        fetchUsers()
        blockedBy()
    }
    

    func fetchUsers(){
        
        COLLECTION_USERS.getDocuments { QuerySnapshot, error in
            if let error = error{
                print("ERROR: SearchViewModel - \(error.localizedDescription)")
                return
            }
            
            guard let documents = QuerySnapshot?.documents else { return }
            
            //            documents.forEach { QueryDocumentSnapshot in
            //                guard let user = try? QueryDocumentSnapshot.data(as: User.self) else { return }
            //                self.users.append(user)
            //            }
            
                        
                        self.users = documents.compactMap { try? $0.data(as: User.self) }

        }
    }
    
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        
        print("DEBUG: blockedByList - \(blockedByList)")
        
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(lowercasedQuery) })
    }
    
    
    func blockedBy() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }

        COLLECTION_BLOCKED.document(uid).collection("blocked-by").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching blocked-by documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let blockedByUserIDs = documents.map { $0.documentID }
        
            for id in blockedByUserIDs {
                COLLECTION_USERS.document(id).getDocument { snapshot, error in
                    guard let user = try? snapshot?.data(as: User.self) else { return }
                    //print("DEBUG: blockedBy - \(user)")
                    self.blockedByList.append(user)
                   // print("DEBUG: blockedByList - \(self.blockedByList)")
                }
            }
            
        }
    }

    
    func filteredUsers2() -> [User] {
        
            return users.filter { user in
                // Check if the user is not in the blockedByList and filter based on the query
                return !blockedByList.contains(where: { $0.id == user.id })
            }
        }
    

    
}
