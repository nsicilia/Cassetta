//
//  DetailPostView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/12/22.
//

import SwiftUI

struct DetailPostView: View {
    @Binding var showStatus: Bool
    //The selected cover image
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    //Image selecter status
    @State var imagePickerPresented = false
    
    //Input Texts
    @State private var title = ""
    @State private var description = "Description..."
    @State private var category = ""
    
    //for color of publish button
    @State var selectedBtn = false
    //AudioURL
    @Binding var combinedURL: URL?
    
    @ObservedObject var viewModel = UploadPostViewModel()
    
    var body: some View {
        
        ScrollView() {
            VStack {
                
                Button {
                    //todo
                    imagePickerPresented.toggle()
                } label: {
                    VStack{
                        if postImage == nil{
                            Image("GenericPhotoIcon")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                            
                            Text("Upload an \n image!")
                                .foregroundColor(.black)
                        }else if let image = postImage{
                            image
                                .resizable()
                                .scaledToFill()
                        }
                    }
                    .frame(width: 200, height: 200)
                    //.background(.gray.opacity(0.5))
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("CassettaBorder"), lineWidth: 2)
                    }
                    .padding(.bottom, 32)
                }
                //The image selection pop-up, runs the loadImage function when the sheet is dismissed
                .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                    //Selects an image from the UIKit image picker, sets that photo to selectedImage var
                    ImagePicker(image: $selectedImage)
                })
                
                
                VStack{
                    CustomTextField(text: $title, placeholder: Text("Title..."),
                                    imageName: "", allLowerCase: false)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("CassettaBorder"), lineWidth: 2)
                            .padding(.horizontal, 32)
                    }
                        
                }
                .frame(width: UIScreen.screenWidth / 0.93)
                .padding(.bottom)
                
                MultilineTextField(text: $description, placeholder: "Description...")
                
                HStack(alignment: .center){
                    Text("Select a category:")
                        .font(.title)
                    
                    Text(category)
                        .foregroundColor(Color("CassettaBrown"))
                        .padding(.top, 6)
                    Spacer()
                }
                .padding(.leading, 32)
                .padding(.vertical)
                
                CategoriesView(value: $category)
                
                Button {
                    //todo
                    if let image = selectedImage {
                        if let audio = combinedURL{
                            viewModel.uploadPost(title: title, description: description, category: category, image: image, audio: audio)
                        }
                    }
                    
                } label: {
                    Text("Test Post")
                }
                .padding()


            }
        }
        .toolbar {
            Button {
                //todo
                selectedBtn.toggle()
                showStatus = false
            } label: {
                VStack{
                    if selectedBtn{
                        ProgressView()
                    }else{
                        Text("Publish")
                            .bold()
                    }
                }
                    .frame(width: 80, height: 30)
                    .background(selectedBtn ? .gray : Color("CassettaOrange"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            

    }
    }

}


extension DetailPostView{
    func loadImage(){
        //if the selectedImage is set we set it to the postImage(the UIKit to swiftui image conversion)
        guard let selectedImage = selectedImage else {return }
        postImage = Image(uiImage: selectedImage)
    }
}

struct DetailPostView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPostView(showStatus: .constant(true), combinedURL: .constant(URL(string: "https://www.apple.com")!))
    }
}
