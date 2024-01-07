//
//  PhoneVerificationView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/21/23.
//

import SwiftUI

struct PhoneVerificationView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var present

    @FocusState private var keyboardFocused: Bool
    @State private var isCodeValid: Bool = false
    @State private var otp: String = ""

    
    var body: some View {
        
    ZStack{
        VStack {
            
            VStack{
                HStack{
                    Button(action: {present.wrappedValue.dismiss()}, label: {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(.black)
                    })
                    
                    Spacer()
                    
                    Text("Verify Phone Number")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    if viewModel.isLoading{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                    }
                    
                }
                .padding()
                
                Text("Code sent to \(viewModel.phoneNumber)")
                    .foregroundColor(.gray)
                    //.padding(.bottom)
                
                Spacer(minLength: 0)
                
                
                ZStack {
                    TextField("Enter OTP", text: $viewModel.code)
                        .padding()
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($keyboardFocused)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                keyboardFocused = true
                            }
                        }
                        .onChange(of: viewModel.code) { newOTP in
                            // Assuming OTP length is 6
                            if newOTP.count == 6 {
                                viewModel.verifyCode()
                            }
                        }
                        .disabled(isCodeValid)
                    // Disable TextField once code is valid
                    .opacity(0)
                    //END: TextField
                    
                    
                    
                    HStack(spacing: 15){
                        ForEach(0..<6, id: \.self){index in
                            CodeView(code: getCodeAtIndex(index: index))
                        }
                    }
                    .padding()
                    .padding(.horizontal, 20)
                }
                Spacer(minLength: 0)
                
                HStack(spacing: 6){
                    Text("Didn't receive the code?")
                        .foregroundColor(.gray)
                    
                    Button(action: {viewModel.requestCode()}, label: {
                        Text("Request Again")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    })
                    
                }
                .padding(.bottom)
//                Button(action: {}, label: {
//                    Text("Get via Call")
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)
//                })
                .padding(.top, 6)
                
                Button(action: {viewModel.verifyCode()}, label: {
                    Text("Veryfy and Create Account")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.screenWidth - 30)
                        .background(Color.black)
                        .cornerRadius(15)
                })
                .padding()
                
            }
            .frame(height: UIScreen.screenHeight / 1.8)
            .background(Color.white)
            .cornerRadius(20)
            
           // CustomNumPadView(value: $viewModel.code, isVerify: true)
            Spacer(minLength: 0)
        }
        .background(Color(.secondarySystemBackground).ignoresSafeArea(.all, edges: .all))
        
        if viewModel.error{
            AlertView(msg: viewModel.errorMsg, showAlert: $viewModel.error)
        }
    }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func getCodeAtIndex(index: Int) -> String{
        if viewModel.code.count > index{
            let start = viewModel.code.startIndex
            let current = viewModel.code.index(start, offsetBy: index)
            return String(viewModel.code[current])
        }
        return ""
    }
}

struct CodeView: View {
    var code : String
    var body: some View{
        VStack(spacing: 10){
            Text(code)
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 45, height: 45)
                .background(Color.white)
                .cornerRadius(10)
            
            //Bottom line
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .frame(width: 45, height: 2)
        }
    }
    
}




#Preview {
    PhoneVerificationView()
        .environmentObject(AuthViewModel())
}
