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
    
    //Duration from previous view
    var audioDuration: Double
    
    //Input Texts
    @State private var title = ""
    @State  var description: String = "Description..."
    @State private var category = ""
    
    //for color of publish button
    @State var selectedBtn = false
    //AudioURL
    @Binding var combinedURL: URL?
    
    @ObservedObject var audioRecorder: AudioRecorderViewModel
    
    @ObservedObject var viewModel = UploadPostViewModel()
    
    
    
    var body: some View {
        
        ScrollViewReader{ scrollVal in
        
        ScrollView() {
            VStack {
                EmptyView()
                    .id(01)
                
                if selectedBtn {
                    ProgressView(value: viewModel.audioProgress)
                        .progressViewStyle(RoundedRectProgressViewStyle())
                        .transition(.move(edge: .bottom))
                        
                }
                
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
                                .aspectRatio(contentMode: .fill)
                            //.frame(width: UIScreen.screenWidth / 1.1, height: UIScreen.screenWidth / 1.4)
                                .cornerRadius(15)
                            
                        }
                    }
                    // .frame(width: 200, height: 200)
                    .frame(width: UIScreen.screenWidth / 1.1, height: UIScreen.screenWidth / 1.4)
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
                    TextField("Title...", text: $title)
                        .padding()
                        .padding(.horizontal,32)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
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
                
                
            }
            
        }
        .onTapGesture {
            self.hideKeyboard()
        }
        .toolbar {
            
            if (selectedImage != nil && title != "" ) {
                
                //The publish button
                Button {
                    //publishin the post
                    if let image = selectedImage {
                        if let audio = combinedURL{
                            selectedBtn.toggle()
                            scrollVal.scrollTo(01)
                            
                            viewModel.uploadPost(title: title, description: description, category: category, image: image, audio: audio, duration: audioDuration){ error in
                                //error handling
                                if let error = error {print("DEBUG: failed to upload an image - \(error.localizedDescription)"); return }
                                //On Completion
                                postImage = nil
                                audioRecorder.deleteAllRecordings()
                                showStatus = false
                            }//completion end
                        }
                    }
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
                }//label
                
            } else {
                Text("Publish")
                    .bold()
                    .frame(width: 80, height: 30)
                    .background(.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
        }
        .navigationBarBackButtonHidden(selectedBtn ? true : false)
    }
}

}

//Styling of the progress bar for the upload
struct RoundedRectProgressViewStyle: ProgressViewStyle {
    let testwidth: CGFloat = CGFloat(UIScreen.screenWidth)
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
                .frame(width: UIScreen.screenWidth - 30, height: 28)
                .foregroundColor(Color("CassettaTan"))
                .overlay(Color.brown.opacity(0.05)).cornerRadius(14)
            
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * abs(testwidth - 30), height: 28)
                .foregroundColor(Color("CassettaOrange"))
        }
        .padding()
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
        DetailPostView(showStatus: .constant(true), audioDuration: 100.0, combinedURL: .constant(URL(string: "https://www.apple.com")!), audioRecorder: AudioRecorderViewModel())
    }
}
