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
    @Binding var selectedButton: String
    @Binding var selectedValue: String
    
    let name: String
    
    
    var body: some View {
        Button(action: {
            self.selected.toggle()
            selectedButton = selectedValue
            
            if selected{
                value = name.unicodeScalars
                    .filter { !$0.properties.isEmojiPresentation }
                    .reduce("") { $0 + String($1) }
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
        }, label: {
            Text(name)
                .padding(10)
                .background(selectedButton == selectedValue ? Color("CassettaOrange") : Color.white)
                .foregroundColor(selectedButton == selectedValue ? Color.white : Color.black)
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
        StyledButton(value: .constant("News"), selectedButton: .constant("📰ham"), selectedValue: .constant("📰ham"), name: "📰 News")
    }
}
