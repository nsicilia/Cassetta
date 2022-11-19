//
//  RegistrationView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State var imagePickerPresented = false
    
    @State private var genericImage = UIImage(named: "GenericUser")
    
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {

            
            Image("CassettaBackground")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                //Logo
                if let image = image{
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                        .padding()
                    
                }else{
                    
                    //Pick a photo button
                    Button {
                        imagePickerPresented.toggle()
                        
                    } label: {
                        VStack{
                            Image("GenericPhotoIcon")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                            
                            Text("Upload an \n image!")
                                .foregroundColor(.black)
                                
                        }
                        .foregroundColor(.black)
                        .padding(.vertical, 32)
                        .padding(.horizontal, 32)
                    }
                    .background(Color(.white))
                    .clipShape(Circle())
                    //The image selection pop-up, runs the loadImage function when the sheet is dismissed
                    .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                        //Selects an image from the UIKit image picker, sets that photo to selectedImage var
                        ImagePicker(image: $selectedImage)
                    })
                    .padding()
                }
                
                VStack(spacing: 20){
                    //email field
                    CustomTextField(text: $email, placeholder: Text("Email..."), imageName: "envelope")
                    
                    //username field
                    CustomTextField(text: $username, placeholder: Text("Username..."), imageName: "person")
                    
                    //full name field
                    CustomTextField(text: $fullname, placeholder: Text("Full Name..."), imageName: "person")

                    //password field
                    CustomSecureField(text: $password, placeholder: Text("Password..."))
                    
                    
                    //sign up
                    Button {
                        //todo
                        viewModel.register(withEmail: email, password: password, image: (selectedImage != nil) ? selectedImage: genericImage, fullname: fullname, username: username)
                        
                    } label: {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color("CassettaOrange"))
                            .clipShape(Capsule())
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button{
                        //go back
                        mode.wrappedValue.dismiss()

                    } label: {
                        HStack{
                            Text("Don't have an account? ")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(8)

                            Text("Sign Up")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .padding(8)

                        }
                        .foregroundColor(.white)
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                    }

                }
            }
        }
    }
}


extension RegistrationView{
    func loadImage(){
        //if the selectedImage is set we set it to the postImage(the UIKit to swiftui image conversion)
        guard let selectedImage = selectedImage else {return }
        image = Image(uiImage: selectedImage)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
