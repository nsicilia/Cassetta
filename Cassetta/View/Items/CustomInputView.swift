//
//  CustomInputView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 4/15/23.
//

import SwiftUI

struct CustomInputView: View {
    @Binding var inputText: String
    
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .center){
            
            //Textinput and send button
            HStack{
                TextField("Comment..", text: $inputText)
                    .textFieldStyle(.plain)
                    .frame(minHeight: 30)
                    .padding(8)
                    .background(.white)
                    .cornerRadius(15)
                
                Button (action: action) {
                    Text("Send")
                        .bold()
                        .foregroundColor(.black)
                }
                
            }
            .padding(.horizontal)
            
            //divider
//            Divider()
//                .padding(.bottom, 8)
        }
       // .frame(height: 40)
        .padding([.top,.bottom], 8)
       // .background(.green)
        
    }
}

struct CustomInputView_Previews: PreviewProvider {
    static var boolHander : () -> Void = {  }
    
    static var previews: some View {
        ZStack{
            Color(.blue).opacity(0.3)
            CustomInputView(inputText: .constant("Comment.."), action: boolHander)
        }
        
    }
}
