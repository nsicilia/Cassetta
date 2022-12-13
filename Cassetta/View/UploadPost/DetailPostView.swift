//
//  DetailPostView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/12/22.
//

import SwiftUI

struct DetailPostView: View {
    @Binding var showStatus: Bool
    
    @State private var title = ""
    @State private var description = "Description..."
    @State private var category = ""
    
    //for color of publish button
    @State var selectedBtn = false
    
    var body: some View {
        
        ScrollView() {
            VStack {
                
                Button {
                    //todo
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
                    .frame(width: 200, height: 200)
                    //.background(.gray.opacity(0.5))
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("CassettaBorder"), lineWidth: 2)
                    }
                    .padding(.bottom, 32)
                }
                
                
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

struct DetailPostView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPostView(showStatus: .constant(true))
    }
}
