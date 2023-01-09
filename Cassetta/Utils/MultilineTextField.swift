//
//  MultilineTextField.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/12/22.
//

import SwiftUI

struct MultilineTextField: View {
    
    @Binding var text: String
    let placeholder: String
        
    
    
    var body: some View {
        
        VStack{
            TextEditor(text: self.$text)
                .foregroundColor(self.text == placeholder ? Color.gray.opacity(0.6) : .primary)
                .onTapGesture {
                    if self.text == placeholder {
                        self.text = ""
                    }
                }
        }
        .frame(width: UIScreen.screenWidth / 1.1, height: 250)
        .padding(6)
        .background(Color(.white))
        .cornerRadius(15.0)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("CassettaBorder"), lineWidth: 2)
        }
    }
    
    
}

struct MultilineTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            MultilineTextField(text: .constant("Description..."), placeholder: "Description...")
        }
    }
}
