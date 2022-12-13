//
//  EmailTextField.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/12/22.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var text: String
    
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty{
                Text("Email...")
                    .foregroundColor(Color(.gray))
                    .padding(.leading, 40)
            }
                HStack{
                    Image(systemName: "envelope")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                    
                    TextField("", text: $text)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .foregroundColor(Color(.black))
                }
            
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(10)
        .foregroundColor(.white)
        .padding(.horizontal, 32)
    }
}

struct EmailTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            EmailTextField(text: .constant(""))
        }
    }
}
