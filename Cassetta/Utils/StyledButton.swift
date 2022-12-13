//
//  Button.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/13/22.
//

import SwiftUI

struct StyledButton: View {
    @State var selected = false
    @Binding var value: String
    
    let name: String
    
    
    var body: some View {
        Button(action: {
            self.selected.toggle()
            
            if selected{
                value = name.unicodeScalars
                    .filter { !$0.properties.isEmojiPresentation }
                    .reduce("") { $0 + String($1) }
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
        }, label: {
            Text(name)
                .padding()
                .background(selected ? Color("CassettaOrange") : Color.white)
                .foregroundColor(selected ? Color.white : Color.black)
                .cornerRadius(15)
        })
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("CassettaBorder"), lineWidth: 2)
        )
    }

}

struct StyledButton_Previews: PreviewProvider {
    static var previews: some View {
        StyledButton(value: .constant("News"), name: "📰 News")
    }
}
