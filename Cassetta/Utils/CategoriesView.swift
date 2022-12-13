//
//  CategoriesView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/13/22.
//

import SwiftUI

struct CategoriesView: View {
    @Binding var value: String
    
    var body: some View {
        
        VStack {
            HStack{
                StyledButton(value: $value, name: "📰 News")
                StyledButton(value: $value, name: "💻 Tech")
                StyledButton(value: $value, name: "🏀 Sports")
            }
            HStack{
                StyledButton(value: $value, name: "🎨 Art")
                StyledButton(value: $value, name: "💰 Finance")
                StyledButton(value: $value, name: "🏀 TV")
            }
            HStack{
                StyledButton(value: $value, name: "💄 Beauty & Fashion")
                StyledButton(value: $value, name: "🌷 Growth")
            }
            HStack{
                StyledButton(value: $value, name: "🥪 Food")
                StyledButton(value: $value, name: "🎵 Music")
                StyledButton(value: $value, name: "👩‍🔬 Career")
            }

        }
        
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(value: .constant("News"))
    }
}
