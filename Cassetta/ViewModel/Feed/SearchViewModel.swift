//
//  SearchViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/19/22.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init(){
        fetchUsers()
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
        
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(lowercasedQuery) })
    }
    
}
