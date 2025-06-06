//
//  ReportSomethingElseView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/25/23.
//

import SwiftUI

struct SomethingElseReportView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var selection: Int = 0
    @Binding var reportSheet: Bool
       
       let pickerItems = [
           ("Its spam", 0),
           ("I don't like it", 1),
           ("Suicide, self-injury or eating disorders", 2),
           ("Sale of illegal or regulated goods", 3),
           ("Nudity or sexual activity", 4),
           ("Hate speech or symbols", 5),
           ("Violence or dangerous organizations", 6),
           ("Bully or harassment", 7),
           ("Intellectual property violation", 8),
           ("Misleading or Possible Scam", 9),
           ("Phishing schemes or other fraudulent activities", 10),
           ("Promoting gambling or betting schemes", 11)
       ]
    
    
    var body: some View {
        VStack(spacing: 0){
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
                .padding(.bottom, 16)
            
            Divider()
            
            List {
                Picker(selection: $selection, label: Text(""), content: {
                    ForEach(pickerItems, id: \.1) { item in
                        Text(item.0).tag(item.1)
                    }
                })
                .pickerStyle(.inline)
            }
            
            Divider()

            
            Button(action: {
                //Todo
                print("Selection: ", selection)
                print("picker: ",pickerItems[selection].0)
                viewModel.reportUser(reason: pickerItems[selection].0 )
                reportSheet = false
            }, label: {
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
    SomethingElseReportView(viewModel: ProfileViewModel(user: User(username: "jessicadoeinton", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jessica Doeinton")), reportSheet: .constant(false))
}
