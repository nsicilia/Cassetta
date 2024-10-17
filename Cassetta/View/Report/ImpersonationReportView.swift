//
//  ImpersonationReportView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/26/23.
//

import SwiftUI

struct ImpersonationReportView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var reportSheet: Bool
    @State private var reportTextplaceholer = "@username \n Full Name"
    @State var reportText: String = ""
    
    var body: some View {

            VStack{
                Text("Report")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)
                
                Text("Who are they pretending to be?")
                    .font(.headline)
                    .bold()
                
                Text("Please provide the username and full name of the person they are impersonating.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding([.leading, .trailing], 16)
                    .padding(.top, 8)
                
                TextField("@username \n Full Name", text: $reportText, axis: .vertical)
                    .lineLimit(4...)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .padding()
                
                
                // Gesture overlay to capture taps in the empty space
                GeometryReader { _ in
                    EmptyView()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    UIApplication.shared.endEdit()
                }
                
                
                
                Button(action: {
                    viewModel.reportUser(reason: reportText)
                }, label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color("CassettaOrange"))
                        .cornerRadius(8)
                        
                    
                })
                
                
            }
        .onTapGesture {
            UIApplication.shared.endEdit()
        }
    }
}

#Preview {
    ImpersonationReportView(viewModel: ProfileViewModel(user: User(username: "jessicadoeinton", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jessica Doeinton")), reportSheet: .constant(false))
}
