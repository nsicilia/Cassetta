//
//  EditProfileView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/23.
//

import SwiftUI
import Kingfisher


struct EditProfileView: View {
    @State private var bioText: String
    @State private var bioTextplaceholer = "Add a bio.."
    
    //fullname
    @State private var fullnameText: String
    @State private var fullnameTextplaceholer = "Add a full name.."
    
    @State var selectedImage: UIImage?
    @State var image: Image?
    @State var imagePickerPresented = false
    
    @State private var isLoading = false // Add a state variable for loading
    
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
                        viewModel.updateProfilePhoto(newImage: selectedImage)
                        isLoading.toggle() // Toggle the loading state
                        
                        // Simulate an asynchronous task (you should replace this with your actual async operation)
                        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                            DispatchQueue.main.async {
                                isLoading.toggle() // Turn off the loading state
                                //mode.wrappedValue.dismiss()
                            }
                        }
                        
                        //mode.wrappedValue.dismiss()
                    } label: {
                        if isLoading {
                            ProgressView() // Show loading animation when isLoading is true
                                //.frame(width: 24, height: 24)
                        } else {
                            Text("Done").bold()
                        }
                    }

                }
                .padding()
                
                //profile photo
                
                if let image = image{
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                        .padding()
                        .padding(.vertical, 32)
                        .padding(.horizontal, 32)
                    
                }else{
                    
                    //Pick a photo button
                    Button {
                        imagePickerPresented.toggle()
                        
                    } label: {
                        VStack{
                            KFImage(URL(string: user.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 110)
                                .clipShape(Circle())
                                .padding()
                        }
                        .foregroundColor(.black)
                        .padding(.vertical, 32)
                        .padding(.horizontal, 32)
                    }
                    .background(Color(.white))
                    .clipShape(Circle())
                    //The image selection pop-up, runs the loadImage function when the sheet is dismissed
                    .sheet(isPresented: $imagePickerPresented, onDismiss: loadImg, content: {
                        //Selects an image from the UIKit image picker, sets that photo to selectedImage var
                        ImagePicker(image: $selectedImage)
                    })
                    .padding()
                }
                

                
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
                    self.user.bio = viewModel.user.bio
                    self.user.fullname = viewModel.user.fullname
                    self.user.profileImageURL = viewModel.user.profileImageURL
                    mode.wrappedValue.dismiss()
                }
            })
    }
        
}


extension EditProfileView{
    func loadImg(){
        //if the selectedImage is set we set it to the postImage(the UIKit to swiftui image conversion)
        guard let selectedImage = selectedImage else {return }
        image = Image(uiImage: selectedImage)
    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: .constant(User(username: "Joe", email: "", profileImageURL: "", fullname: "", bio: "")))
    
    }
}
