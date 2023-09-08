//
//  EditProfileView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/23.
//

import SwiftUI

struct EditProfileView: View {
    @State private var bioText: String
    @State private var bioTextplaceholer = "Add a bio.."
    
    //fullname
    @State private var fullnameText: String
    @State private var fullnameTextplaceholer = "Add a full name.."
    
    
    @ObservedObject var viewModel: EditProfileViewModel
    @Binding var user: User
    
    @Environment(\.presentationMode) var mode
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._bioText = State(initialValue: _user.wrappedValue.bio ?? "")
        self._fullnameText = State(initialValue: _user.wrappedValue.fullname)
    
    }
    
    
    var body: some View {
            VStack{
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    Spacer()
                    
                    Button {
                        viewModel.saveUserBio(bioText)
                        viewModel.saveUserFullname(fullnameText)
                        mode.wrappedValue.dismiss()
                    } label: {
                        Text("Done").bold()
                    }

                }
                .padding()
                
                ZStack {
                    if fullnameText.isEmpty {
                        TextEditor(text:$fullnameTextplaceholer)
                            .font(.body)
                            .foregroundColor(.gray)
                            .disabled(true)
                            .padding()
                    }
                    TextEditor(text: $fullnameText)
                        .font(.body)
                        .opacity(fullnameText.isEmpty ? 0.25 : 1)
                        .padding()
                }
                .frame(height: 70)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding()
                
                
                ZStack {
                    if bioText.isEmpty {
                        TextEditor(text:$bioTextplaceholer)
                            .font(.body)
                            .foregroundColor(.gray)
                            .disabled(true)
                            .padding()
                    }
                    TextEditor(text: $bioText)
                        .font(.body)
                        .opacity(bioText.isEmpty ? 0.25 : 1)
                        .padding()
                }
                .frame(height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding()
                
                    
                
                Spacer()
            }
            .onReceive(viewModel.$uploadComplete, perform: { completed in
                if completed {
                    mode.wrappedValue.dismiss()
                    self.user.bio = viewModel.user.bio
                    self.user.fullname = viewModel.user.fullname
                
                }
            })
    }
        
}



struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: .constant(User(username: "Joe", email: "", profileImageURL: "", fullname: "", bio: "")))
    
    }
}
