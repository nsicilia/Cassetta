//
//  CustomSecureField.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: Text
    let newPassword: Bool
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty{
                placeholder
                    .foregroundColor(Color(.gray))
                    .padding(.leading, 40)
            }
                HStack{
                    Image(systemName: "lock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                    
                    SecureField("", text: $text)
                        .textContentType(newPassword ? .newPassword : .password)
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

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            CustomSecureField(text: .constant(""), placeholder: Text("Password..."), newPassword: true)
        }
    }
}
