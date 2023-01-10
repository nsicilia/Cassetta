//
//  CategoriesView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/13/22.
//

import SwiftUI

struct CategoriesView: View {
    @Binding var value: String
    @State var selectedButton: Int = 0
    
    var body: some View {
        
        VStack {
            HStack{
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(1), name: "📰 News")
                StyledButton(value: $value, selectedButton: $selectedButton,  selectedValue: .constant(2), name: "💻 Tech")
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(3), name: "🏀 Sports")
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(4), name: "🎨 Art")
            }
            HStack{
//                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(4), name: "🎨 Art")
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(5), name: "💰 Finance")
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(6), name: "📺 TV")
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(7), name: "💄 Beauty & Fashion")
            }
            HStack{
//                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(7), name: "💄 Beauty & Fashion")
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(8), name: "🌷 Growth")
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(9), name: "🥪 Food")
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(10), name: "🎵 Music")
            }
            HStack{
                
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(11), name: "👩‍🔬 Career")
            }

        }
        
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(value: .constant("News"))
    }
}
