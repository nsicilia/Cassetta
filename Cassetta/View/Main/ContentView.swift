//
//  ContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/7/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseAppCheck

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var userLoggedIn = false
    
    var body: some View {
        VStack{
            if userLoggedIn{
                if let user = viewModel.currentUser{
                                       TabBarView(user: user)
                                    }
            } else {
                LoginView()
            }
            
            
        }.onAppear{
            Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                    if let error = error { logAuthError(error); return }
                    print("3BUG: New ID token: \(idToken ?? "nil")")
                  }
            
            AppCheck.appCheck().token(forcingRefresh: true) { token, error in
                    if let error = error { logAuthError(error); return }
                    print("3BUG: App Check Token: \(token?.token ?? "nil")")
                  }
            
            Auth.auth().addStateDidChangeListener { _, user in
                    userLoggedIn = (user != nil)
                print("3BUG: User logged in: \(userLoggedIn)")
                  }
        }
    }
    
//    var body: some View {
//        
//        ZStack {
//            
//            Group {
//                if viewModel.userSession == nil{
//                    //LoginView()
//                    
//                        PhoneLoginView()
//                            .navigationBarHidden(true)
//                            .navigationBarBackButtonHidden(true)
//                    
//                } else{
//                    if let user = viewModel.currentUser{
//                        TabBarView(user: user)
//                        //MainTabView(user: user)
//                    }
//                }
//            }
//        }
////        .onAppear(){
////            viewModel.signout()
////        }
//            
//    }
}

func logAuthError(_ error: Error) {
  let nsError = error as NSError
  print("3BUG: Auth error code: \(nsError.code)")
  print("3BUG: Domain: \(nsError.domain)")
  print("3BUG: UserInfo: \(nsError.userInfo)")
    if let authCode = AuthErrorCode(rawValue: nsError.code) {
        print("3BUG: AuthErrorCode: \(authCode)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
