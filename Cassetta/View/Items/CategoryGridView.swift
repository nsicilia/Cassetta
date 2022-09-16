//
//  CategoryGridView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI

struct CategoryGridView: View {
    let data = (1...100).map { "Item \($0)" }

    let columns = [
        GridItem(.flexible()),
                GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 22) {
                
                //todo: Make a for each with all the titles emojis and link location
                
                Group{
                    
                    NavigationLink {
                        Feed()
                    } label: {
                        CategoryCell(categoryTitle: "News", cetegoryEmoji: "📰")
                            .foregroundColor(Color(UIColor.label))
                    }
                    
                    CategoryCell(categoryTitle: "Tech", cetegoryEmoji: "💻")
                    
                    CategoryCell(categoryTitle: "Crypto", cetegoryEmoji: "💰")
                    
                    CategoryCell(categoryTitle: "Sports", cetegoryEmoji: "🏀")
                    
                    CategoryCell(categoryTitle: "TV & Media", cetegoryEmoji: "📺")
                    
                    CategoryCell(categoryTitle: "Career", cetegoryEmoji: "👩‍🔬")
                }
                
                Group{
                    CategoryCell(categoryTitle: "Personal Growth", cetegoryEmoji: "🌷")
                    
                    CategoryCell(categoryTitle: "Fashion & Beauty", cetegoryEmoji: "💃")
                    
                    CategoryCell(categoryTitle: "Art", cetegoryEmoji: "🎨")
                    
                    CategoryCell(categoryTitle: "Music", cetegoryEmoji: "🎵")
                    
                    CategoryCell(categoryTitle: "Food", cetegoryEmoji: "🥪")
                    
                    CategoryCell(categoryTitle: "Travel", cetegoryEmoji: "✈️")
                }
                
                
                
            }
            .padding(.horizontal, 4)
        }
    }
}

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView()
    }
}
