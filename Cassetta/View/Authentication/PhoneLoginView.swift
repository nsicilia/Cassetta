//
//  PhoneLoginView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/21/23.
//

import SwiftUI

struct PhoneLoginView: View {
    @StateObject var viewModel = PhoneLoginViewModel()
    @State var isSmallScreen = UIScreen.screenHeight < 750
    
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
                    Text("Phone Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    Image(systemName: "phone")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    Text("You will receive a text with a code to verify your phone number")
                        .font(isSmallScreen ? .none : .title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    //Number Field
                    
                    HStack(){
                        VStack(alignment: .leading, spacing: 6){
                            Text("Enter your phone number")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("+ \(viewModel.getCountryCode()) \(viewModel.phoneNumber)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                        }
                        Spacer(minLength: 0)
                        
//                        NavigationLink {
//                            PhoneVerificationView(viewModel: viewModel, isActive: $viewModel.goToVerify)
//                            
//                        } label: {
//                            Text("")
//                                .hidden()
//                        }
                        NavigationLink(destination: PhoneVerificationView(viewModel: viewModel), isActive: $viewModel.goToVerify) {
                            Text("")
                                .hidden()
                        }
                        
                        Button(action: {viewModel.sendCode()}, label: {
                            Text("Continue")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(Color.black)
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
                
                //Custom number pad
                CustomNumPadView(value: $viewModel.phoneNumber, isVerify: false)

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
}
