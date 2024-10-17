//
//  ReportView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/24/23.
//

import SwiftUI

struct ReportView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var reportSheet: Bool
    
    var body: some View {
        NavigationView{
            
        VStack{
            Text("Report")
                .font(.title)
                .bold()
                .padding(.bottom, 8)
            
            Text("What do you want to report?")
                .font(.headline)
                .bold()
            Text("Your report will be sent to the Cassetta team for review. Your report is anonymous. If someone is in immediate danger, call local emergency services.")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal, 36)
                .padding(.top, 8)
         
                List {
                    NavigationLink(destination: ImpersonationReportView(viewModel: viewModel, reportSheet: $reportSheet)) { Text("They are pretending to be someone else") }
                    
                    NavigationLink(destination: UnderAgeReportView(viewModel: viewModel, reportSheet: $reportSheet)) { Text("They may be under the age of 13") }
                    
                    NavigationLink(destination: SomethingElseReportView(viewModel: viewModel, reportSheet: $reportSheet)) { Text("Something Else") }
                }

            
        }
        .padding(.top, 48)
            
        }
        //.presentationDetents([.medium, .large])
        .presentationDetents([.fraction(0.8),.fraction(0.99)])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    ReportView(viewModel: ProfileViewModel(user: User(username: "jessicadoeinton", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jessica Doeinton")), reportSheet: .constant(false))
}
