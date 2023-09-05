//
//  ForgetPasswordView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI

struct ForgetPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var email:String
    @Environment(\.presentationMode) var mode
    
    init(email: Binding<String>){
        self._email = email
    }
    
    var body: some View {
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
                
                    //forgot password
                    HStack{
                        Spacer()

                    }
                    .padding(.horizontal, 32)
                    
                    //sign in
                    
                    Button {
                        //todo
                        viewModel.resetPassword(withEmail: email)
                    } label: {
                        Text("Send Reset Password Link")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color("CassettaOrange"))
                            .clipShape(Capsule())
                            .padding()
                    }
                    
                    Spacer()
                    
                    //Switch to sign up button
                    
                    Button{
                        //go back
                        mode.wrappedValue.dismiss()
                        
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
        .onReceive(viewModel.$didSendPasswordLink) { _ in
            self.mode.wrappedValue.dismiss()
        }
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView(email: .constant("")).environmentObject(AuthViewModel())
    }
}
