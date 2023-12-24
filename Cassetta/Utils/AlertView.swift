//
//  AlertView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/22/23.
//

import SwiftUI

struct AlertView: View {
    var msg: String
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("Message")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text(msg)
                .foregroundColor(.gray)
            
            Button(action: {
               // withAnimation(.easeInOut) {
                    showAlert.toggle()
                //}
            }, label: {
                Text("Cancel")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.screenWidth - 100)
                    .background(Color.yellow)
                    .cornerRadius(15)
                
            })
            .frame(alignment: .center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal, 25)
        
        //Background dim and color
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3).ignoresSafeArea(.all, edges: .all))
    }
}

#Preview {
    AlertView(msg: "Error: something bad is currently happening...", showAlert: .constant(true))
}
