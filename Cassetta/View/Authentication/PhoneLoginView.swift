//
//  PhoneLoginView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/21/23.
//

import SwiftUI

struct PhoneLoginView: View {
    //@StateObject var viewModel = PhoneLoginViewModel()
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel
    @State var isSmallScreen = UIScreen.screenHeight < 750
    
    @FocusState private var keyboardFocused: Bool
    let characterLimit = 10

    
    var body: some View {
        NavigationView{
        ZStack {
            Image("CassettaBackground")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
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
                    
                    
                    
                    NavigationLink{
                        LoginView().navigationBarHidden(true)
                    } label: {
                        HStack{
                            Text("Prefer email? ")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                            
                            Text("Sign Up")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                            
                        }
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                    }
                    
                    //Number Field
                    
                    HStack(){
                        VStack(alignment: .leading, spacing: 6){
                            Text("Enter your phone number")
                                .font(.caption)
                                .foregroundColor(.gray)
                            ZStack{
                                TextField("", text: $viewModel.phoneNumber)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    //.background(Color.pink)
                                    .keyboardType(.numberPad)
                                    .focused($keyboardFocused)
                                    .onChange(of: viewModel.phoneNumber) { newValue in
                                        // Limit the number of characters
                                        if newValue.count > characterLimit {
                                            viewModel.phoneNumber = String(newValue.prefix(characterLimit))
                                            print("limiting characters /n \(viewModel.phoneNumber)")
                                        }
                                    }
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            keyboardFocused = true
                                        }
                                    }
                                    .padding(.leading, 35)
                                
                                HStack{
                                    Text("+ \(viewModel.getCountryCode()) \(viewModel.phoneNumber)")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    Spacer(minLength: 0)
                                }
                               
                            }
                            
                        }
                        Spacer(minLength: 0)
                        
                        NavigationLink(destination: PhoneVerificationView(viewModel: _viewModel), isActive: $viewModel.goToVerify) {
                            Text("")
                                .hidden()
                        }
                        
                        Button(action: {viewModel.sendCode()}, label: {
                            Text("Continue")
                                .foregroundColor(.white)
                                .bold()
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color(.cassettaOrange))
                                .clipShape(Capsule())
                        })
                        .disabled(viewModel.phoneNumber == "" ? true : false)
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: -5)
                }
                .frame(height: UIScreen.screenHeight / 1.8)
                //.background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 8)
                
                //Custom number pad
                //CustomNumPadView(value: $viewModel.phoneNumber, isVerify: false)
                Spacer(minLength: 0)

            }
            
            if viewModel.error{
                AlertView(msg: viewModel.errorMsg, showAlert: $viewModel.error)
            }
        }
        //.background(Color(.secondarySystemBackground).ignoresSafeArea(.all, edges: .bottom))
    }
    }
    
}


#Preview {
    PhoneLoginView()
        .environmentObject(AuthViewModel())
}
