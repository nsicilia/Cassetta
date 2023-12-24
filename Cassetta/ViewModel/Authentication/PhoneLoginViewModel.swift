//
//  PhoneLoginViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/21/23.
//
import SwiftUI
import Foundation
import Firebase

class PhoneLoginViewModel: ObservableObject{
    @Published var phoneNumber = ""
    @Published var code = ""
    
    //DataModel for Error View
    @Published var errorMsg = ""
    @Published var error = false
    
    //Storing code for verification
    @Published var CODE = ""
    @Published var goToVerify = false
    

    
    //Get country phone code
    func getCountryCode() -> String{
        let regionCode = Locale.current.regionCode ?? ""
        return countries[regionCode] ?? ""
    }
    
    func sendCode(){
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let number = "+\(getCountryCode())\(phoneNumber)"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            if let error = err{
                self.errorMsg = error.localizedDescription
                self.error.toggle()
                return
            }
            
            self.CODE = CODE ?? ""
            self.goToVerify = true
            
            //Code sent successfully
            print("Code Sent")
        }
    }
    
//    func verifyCode(){
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
//        
//        isLoading = true
//        
//        Auth.auth().signIn(with: credential) { (res, err) in
//            if let error = err{
//                self.errorMsg = error.localizedDescription
//                withAnimation{ self.error.toggle()}
//                return
//            }
//            
//            self.isLoading = false
//            
//            guard let user = res?.user else {return}
//            AuthViewModel().userSession = user
//            AuthViewModel().fetchUser()
//            AuthViewModel().loginFail = false
//            
//            //else logged in successfully
//            self.status = true
//        }
//    }
    
//    func requestCode(){
//        sendCode()
//        withAnimation {
//            self.errorMsg = "Code Successfully Sent"
//            self.error.toggle()
//        }
//    }
    
    
}//END Class
