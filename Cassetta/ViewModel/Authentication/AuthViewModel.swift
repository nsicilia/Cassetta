//
//  AuthViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/4/22.
//

import SwiftUI
import Firebase


class AuthViewModel: ObservableObject{
    
    @Published var userSession: FirebaseAuth.User?
    
    //initialize the user session to current user
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func login(){
        print("Login")
    }
    
    //register a new user, currently: Email, Password
    func register(withEmail email: String, password: String){
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else{ return }
            self.userSession = user
            
            print("Succsessfully registered user")
        }
        
        print("Register")
        print(email)
        print(password)
    }
    
    func signout(){
        
    }
    
    func resetPassword(){
        
    }
    
    func fetchUser(){
        
    }
}
