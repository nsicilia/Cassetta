//
//  AuthViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/4/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var didSendPasswordLink = false
    
    //continue button on phone login
    @Published var continueLoading = false
    
    @Published var loginFail = false
    
    static let shared = AuthViewModel()
    
    
    //TEST
    @Published var phoneNumber = ""
    @Published var code = ""
    
    //DataModel for Error View
    @Published var errorMsg = ""
    @Published var error = false
    
    //Storing code for verification
    @Published var CODE = ""
    @Published var goToVerify = false
    
    //User logged in status
    @AppStorage("log_Status") var status = false
    
    //Loading view
    @Published var isLoading = false
    //TEST END
    
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                self.loginFail = true
                print("DEBUG: Login failed - \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            self.loginFail = false
        
        }
    }
    
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String){
            
        guard let image = image else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else { return }
                
                // Update the user's profile with the image URL
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.photoURL = URL(string: imageUrl)
                changeRequest.displayName = fullname
                
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("Error updating user profile: \(error.localizedDescription)")
                        return
                    }
                    
                    // Aggregate user information
                    let data = [
                        "email": email,
                        "username": username,
                        "fullname": fullname,
                        "profileImageURL": imageUrl,
                        "uid": user.uid
                    ]
                    
                    // Upload user data to Firestore
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                        if let error = error {
                            print("Error uploading user data: \(error.localizedDescription)")
                            return
                        }
                        
                        // Registration and data upload successful
                        self.userSession = user
                        self.fetchUser()
                    }
                }
            }
        }
    }

    
    func signout(){
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword(withEmail email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Failed to send link \(error.localizedDescription)")
            }
            self.didSendPasswordLink = true
        }
    }
    
    func fetchUser(){
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { SnapshotData, error in
            if let error = error{
                print("DEBUG: fetchUser() - \(error.localizedDescription)")
                return
            }
            
            guard let user = try? SnapshotData?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
    
    
    //Get country phone code
    func getCountryCode() -> String{
        let regionCode = Locale.current.region?.identifier ?? ""
        return countries[regionCode] ?? ""
    }
    
    //Send a verification code for phone number login/signup
    func sendCode(){
        
       // Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let number = "+\(getCountryCode())\(phoneNumber)"
        print("Number is \(number)")
        
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            if let error = err{
                self.errorMsg = error.localizedDescription
                self.loginFail = true
                withAnimation{ self.error.toggle()}
                return
            }
            
            self.CODE = CODE ?? ""
            self.goToVerify = true
            
            //Code sent successfully
            print("Code Sent")
        }
    }
    
    func requestCode(){
        sendCode()
        withAnimation {
            self.errorMsg = "Code Successfully Sent"
            self.error.toggle()
        }
    }
    
    func verifyCode() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        isLoading = true
        
        let random = generateUniqueUsername()
        
        guard let image = UIImage(named: "GenericUser") else { return }
        let fullname = random
        let username = random
        //let email = "user\(random)@gmail.com"
        let email = ""
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            Auth.auth().signIn(with: credential) { (res, err) in
                if let error = err {
                    self.errorMsg = error.localizedDescription
                    self.isLoading = false
                    withAnimation { self.error.toggle() }
                    return
                }
                
                self.isLoading = false
                guard let user = res?.user else { return }
                
                // Check if user already exists in Firestore
                Firestore.firestore().collection("users").document(user.uid).getDocument { (document, error) in
                    if let document = document, document.exists {
                        // User document already exists, don't add data
                        print("User data already exists in Firestore")
                        
                        // You may want to handle this case accordingly
                        // For example, update userSession or fetch user data
                        self.userSession = user
                        self.fetchUser()
                        self.loginFail = false
                    } else {
                        // User document doesn't exist, add data to Firestore
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.photoURL = URL(string: imageUrl)
                        changeRequest.displayName = fullname
                        
                        changeRequest.commitChanges { error in
                            if let error = error {
                                print("Error updating user profile: \(error.localizedDescription)")
                                return
                            }
                            
                            // Aggregate user information
                            let data = [
                                "email": email,
                                "username": username,
                                "fullname": fullname,
                                "profileImageURL": imageUrl,
                                "uid": user.uid,
                                "phoneNumber": "+\(self.getCountryCode())\(self.phoneNumber)"
                            ]
                            
                            // Upload user data to Firestore
                            Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                                if let error = error {
                                    print("Error uploading user data: \(error.localizedDescription)")
                                    return
                                }
                                
                                // Registration and data upload successful
                                self.userSession = user
                                self.fetchUser()
                                self.loginFail = false
                            }
                        }
                        
                        // Else logged in successfully
                        self.status = true
                        print("Success login")
                    }
                }
            }
        }
    }

    
//    func verifyCode(){
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
//        
//        isLoading = true
//        
//        let random = generateUniqueUsername()
//        
//        guard let image = UIImage(named: "GenericUser") else { return }
//        let fullname = random
//        let username = random
//        //let email = "user\(random)@gmail.com"
//        let email = ""
//        
//        
//        
//        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
//            Auth.auth().signIn(with: credential) { (res, err) in
//                if let error = err{
//                    self.errorMsg = error.localizedDescription
//                    self.isLoading = false
//                    withAnimation{ self.error.toggle()}
//                    return
//                }
//                
//                self.isLoading = false
//                guard let user = res?.user else { return }
//                
//                // Update the user's profile with the image URL
//                let changeRequest = user.createProfileChangeRequest()
//                changeRequest.photoURL = URL(string: imageUrl)
//                changeRequest.displayName = fullname
//                
//                changeRequest.commitChanges { error in
//                    if let error = error {
//                        print("Error updating user profile: \(error.localizedDescription)")
//                        return
//                    }
//                    
//                    // Aggregate user information
//                    let data = [
//                        "email": email,
//                        "username": username,
//                        "fullname": fullname,
//                        "profileImageURL": imageUrl,
//                        "uid": user.uid,
//                        "phoneNumber": "+\(self.getCountryCode())\(self.phoneNumber)"
//                    ]
//                    
//                    // Upload user data to Firestore
//                    Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
//                        if let error = error {
//                            print("Error uploading user data: \(error.localizedDescription)")
//                            return
//                        }
//                        
//                        // Registration and data upload successful
//                        self.userSession = user
//                        self.fetchUser()
//                        self.loginFail = false
//                    }
//                }
//                
//                //else logged in successfully
//                self.status = true
//                print("Success login")
//            }//End of Auth
//        }
//        
//    }//End of Verify Code
    
    
    func checkUsernameAvailability(_ username: String) -> Bool {
        var isUsernameAvailable = false

        // Query Firestore to check if the username is already taken
        Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments { snapshot, error in
            if let error = error {
                print("Error checking username availability: \(error.localizedDescription)")
                // Handle the error as needed
                return
            }

            // If the snapshot is empty, the username is available
            isUsernameAvailable = snapshot?.documents.isEmpty ?? true
        }

        return isUsernameAvailable
    }

    
    func generateUniqueUsername() -> String {
        var username: String
        repeat {
            // Generate a random number or string
            let random = arc4random_uniform(1000) // Adjust the range as needed
            username = "user\(random)"
        } while checkUsernameAvailability(username)

        return username
    }
    

    
}//End of class

