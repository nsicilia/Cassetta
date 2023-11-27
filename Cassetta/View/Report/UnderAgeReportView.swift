//
//  ReportUnderAgeView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/25/23.
//

import SwiftUI

struct UnderAgeReportView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var reportSheet: Bool
    var body: some View {
        VStack(spacing: 0){
            Text("Report")
                .font(.title)
                .bold()
                .padding(.bottom, 8)
            
            Text("Reporting User for Age Violation")
                .font(.headline)
                .bold()
            
            Text("If you believe that a user on this platform is under the age of 13, you can report this concern to help maintain a safe and compliant community. Reporting underage users is crucial for the safety of everyone on this platform.")
                .font(.caption)
                   .multilineTextAlignment(.center)
                     .foregroundColor(.secondary)
                   .padding([.leading, .trailing], 16)
                   .padding(.top, 8)
            

            Spacer(minLength: 0)
            
            Button(action: {}, label: {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color("CassettaOrange"))
                    .cornerRadius(8)
                    .padding(.top, 24)
                
            })
            
            
        }
        .padding(.top, 48)
        
    }
}

#Preview {
    UnderAgeReportView(viewModel: ProfileViewModel(user: User(username: "jessicadoeinton", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jessica Doeinton")), reportSheet: .constant(false))
}
