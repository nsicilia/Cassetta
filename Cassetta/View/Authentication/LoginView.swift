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
//                LinearGradient(
//                    gradient: Gradient(stops: [
//                        .init(color: Color("CassettaYellow"), location: 0),
//                        .init(color: Color("CassettaOrange"), location: 0.42),
//                        .init(color: Color("CassettaOrange"), location: 1)
//                                ]),
//                    startPoint: .topLeading ,
//                    endPoint: .bottomTrailing)
//                    .ignoresSafeArea()
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
                        //CustomTextField(text: $email, placeholder: Text("Email..."), imageName: "envelope")
                        EmailTextField(text: $email)
                        
                        //password field
                        CustomSecureField(text: $password, placeholder: Text("Password..."), newPassword: false)

                        
                        //forgot password
                        HStack{
                            Spacer()
                            
                            Button {
                                //todo
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
                        
                        Spacer()
                        
                        //Switch to sign up button
                        NavigationLink{
                            RegistrationView().navigationBarHidden(true)
                        } label: {
                            HStack{
                                Text("Don't have an account? ")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .padding(8)

                                Text("Sign Up")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(8)

                            }
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
