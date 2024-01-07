//
//  EditProfileView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/23.
//

import SwiftUI
import Kingfisher
import Firebase


struct EditProfileView: View {
    //bio
    @State private var bioText: String
    @State private var bioTextplaceholer = "Add a bio.."
    
    //fullname
    @State private var fullnameText: String
   // @State private var fullnameTextplaceholer = "Add a full name.."
    
    //username
    @State private var usernameText: String
    @State private var isUsernameAvailable: Bool = true
    
    //profile image
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
        
        self._usernameText = State(initialValue: _user.wrappedValue.username)
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
                        viewModel.saveUsername(usernameText)
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
                    }//done button
                    .disabled(!isUsernameAvailable)

                }
                .padding()
                ScrollView{
                    VStack{
                        
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
                                        .background(Color(.cassettaTan))
                                        .clipShape(Circle())
                                        .padding()
                                    
                                }
                                .foregroundColor(.black)
                                .padding(.vertical, 32)
                                .padding(.horizontal, 32)
                            }
                            .clipShape(Circle())
                            
                            
                            //The image selection pop-up, runs the loadImage function when the sheet is dismissed
                            .sheet(isPresented: $imagePickerPresented, onDismiss: loadImg, content: {
                                //Selects an image from the UIKit image picker, sets that photo to selectedImage var
                                ImagePicker(image: $selectedImage)
                            })
                            .padding()
                        }
                        
                        
                        //Fullname
                        VStack(alignment: .leading) {
                            Text("Full Name")
                                .font(.subheadline)
                                           .foregroundColor(.gray)
                                           .padding(.leading, 16)
                            ZStack {
                                TextField("Full Name", text: $fullnameText)
                                    .font(.body)
                                    .padding()
                                
                            }
                            .frame(height: 70)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        }
                        .padding()
                        
                        //Username
                        VStack(alignment: .leading) {
                            Text("User Name")
                                .font(.subheadline)
                                           .foregroundColor(.gray)
                                           .padding(.leading, 16)
                            ZStack {
                                TextField("User Name", text: $usernameText)
                                    .keyboardType(.URL)
                                    .textInputAutocapitalization(.never)
                                    .font(.body)
                                    .padding()
                                    .onChange(of: usernameText, perform: { newValue in
                                        usernameText = newValue.lowercased()
                                        checkUsernameAvailability(newValue)
                                                        })
                                
                            }
                            .frame(height: 70)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                            )
                            
                            if !isUsernameAvailable {
                                Text("This username is already taken")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.leading, 16)
                            }
                        }
                        .padding()
                        
                        //Bio
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
                        
                        
                        //End of section
                        Spacer()
                        
                    }
                }
            }
            .onReceive(viewModel.$uploadComplete, perform: { completed in
                if completed {
                    self.user.bio = viewModel.user.bio
                    self.user.fullname = viewModel.user.fullname
                    self.user.profileImageURL = viewModel.user.profileImageURL
                    self.user.username = viewModel.user.username
                    mode.wrappedValue.dismiss()
                }
            })
    }
    
    
    //MARK: - Functions
    //Checks if the username is available
    private func checkUsernameAvailability(_ username: String) -> Bool {
        //var isUsernameAvailable = false

        // Query Firestore to check if the username is already taken
        Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments { snapshot, error in
            if let error = error {
                print("Error checking username availability: \(error.localizedDescription)")
                // Handle the error as needed
                return
            }

            // If the snapshot is empty, the username is available
            isUsernameAvailable = snapshot?.documents.isEmpty ?? true
        }

        return isUsernameAvailable
    }
    
    
}//END: struct EditProfileView

//MARK: - Extensions
extension EditProfileView{
    func loadImg(){
        //if the selectedImage is set we set it to the postImage(the UIKit to swiftui image conversion)
        guard let selectedImage = selectedImage else {return }
        image = Image(uiImage: selectedImage)
    }
}


//MARK: - Preview
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: .constant(User(username: "joe548", email: "", profileImageURL: "", fullname: "Joe Johnson", bio: "")))
    
    }
}
