//
//  CategoriesView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/13/22.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var originalItems = [
        "🎨 Art",
        "👂 ASMR",
        "💅 Beauty",
        "📚 Books",
        "📈 Business",
        "🗃️ Career",
        "📸 Celebs",
        "🎭 Comedy",
        "🙏 Culture",
        "📓 Education",
        "📣 Entertainment",
        "👠 Fashion",
        "💵 Finance",
        "🍔 Food",
        "🌱 Growth",
        "🩺 Health",
        "📜 History",
        "🗣️ Language",
        "🏡 Lifestyle",
        "🎵 Music",
        "📰 News",
        "💭 Philosophy",
        "❤️ Relationships",
        "🧪 Science",
        "🏀 Sports",
        "💻 Tech",
        "🔍 True Crime",
        "📺 TV",
        "👾 Video Games"
    ]
    
    @Published var spacing: CGFloat = 12
    @Published var padding: CGFloat = 22
    @Published var wordCount: Int = 75
    @Published var alignmentIndex = 0
    
    var words: [String] {
        Array(originalItems.prefix(wordCount))
    }
    
}


struct CategoriesView: View {
    @Binding var value: String
    @State var selectedButton: String = ""
    @StateObject var model = ContentViewModel()
    
    var body: some View {
        
        VStack{
            FlexibleView(
                data: model.words,
                spacing: model.spacing,
                alignment: .center
            ) { item in
                
                StyledButton(value: $value, selectedButton: $selectedButton, selectedValue: .constant(item), name: item)
                
            }
            .padding(.horizontal, model.padding)
        }
        
        
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(value: .constant("News"))
    }
}
