//
//  LoginView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("CassettaBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    //Logo
                    Image("BlackCassettaLogo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .scaledToFill()
                        .frame(width: 150, height: 60)
                        .padding(.top)
                        .padding(.bottom, 32)
                    
                    VStack(spacing: 20){
                        //email field
                        EmailTextField(text: $email)
                        
                        //password field
                        CustomSecureField(text: $password, placeholder: Text("Password..."), newPassword: false)
                        
                        
                        //forgot password
                        HStack{
                            Spacer()
                            
                            NavigationLink {
                                ForgetPasswordView(email: $email)
                            } label: {
                                Text("Forgot Password")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                
                            }
                            
                        }
                        .padding(.horizontal, 32)
                        
                        //sign in
                        
                        Button {
                            //todo
                            viewModel.login(withEmail: email, password: password)
                            
                        } label: {
                            Text("Sign In ")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 360, height: 50)
                                .background(Color("CassettaOrange"))
                                .clipShape(Capsule())
                                .padding()
                        }
                        
                        if viewModel.loginFail {
                            Text("Login failed. \n Please check your email and password.")
                                .font(.system(size: 16, weight: .bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.red)
                                .padding()
                                .background(.white)
                                .cornerRadius(15)
                                
                        }

                        
                        Spacer()
                        
                        //Switch to sign up button
                        HStack {
                            NavigationLink{
                                PhoneLoginView().navigationBarHidden(true)
                            } label: {
                                HStack{
                                    Text("Login/Signup with phone")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                        .bold()
                                    
                                }
                                .padding(8)
                                .foregroundColor(.white)
                                .background(.white)
                                .cornerRadius(10)
                                .padding()
                        }
                            
                            
                            NavigationLink{
                                RegistrationView().navigationBarHidden(true)
                            } label: {
                                HStack{
                                    Text("Signup with email")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                        .bold()
                                        
                                    
                                }
                                .padding(8)
                                .foregroundColor(.white)
                                .background(.white)
                                .cornerRadius(10)
                                .padding()
                        }
                        }
                        
                        
                    }
                    
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    
    }
}
