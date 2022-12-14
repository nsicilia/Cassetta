//
//  CustomTextField.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    let allLowerCase: Bool
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty{
                placeholder
                    .foregroundColor(Color(.gray))
                    .padding(.leading, imageName.isEmpty ? 0 : 40)
            }
                HStack{
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                    
                    TextField("", text: $text)
                        .foregroundColor(Color(.black))
                        .textCase( allLowerCase ? .lowercase : .lowercase)
                        .autocapitalization(allLowerCase ? .none : .sentences)
                        
                }
            
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(10)
        .foregroundColor(.white)
        .padding(.horizontal, 32)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            CustomTextField(text: .constant(""), placeholder: Text("Email..."), imageName: "envelope", allLowerCase: true)
        }
            
    }
}
