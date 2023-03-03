//
//  CategoryGridView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI

struct CategoryGridView: View {

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    let categoryData = [
        CategoryData(id: 1, title: "News", emoji: "📰"),
        CategoryData(id: 2, title: "Tech", emoji: "💻"),
        CategoryData(id: 3, title: "Crypto", emoji: "💰"),
        CategoryData(id: 4, title: "Sports", emoji: "🏀"),
        CategoryData(id: 5, title: "TV & Media", emoji: "📺"),
        CategoryData(id: 6, title: "Career", emoji: "👩‍🔬")
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 22) {
                ForEach(categoryData) { category in
                    NavigationLink(destination: Text("Coming")) {
                        CategoryCell(categoryTitle: category.title, cetegoryEmoji: category.emoji)
                            .foregroundColor(Color(UIColor.label))
                    }
                }
            }
            .padding(.horizontal, 4)
            .padding(.top)
        }
    }
}

struct CategoryData: Identifiable {
    var id: Int
    
    let title: String
    let emoji: String
}


struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView()
            .background(Color("CassettaTan"))
    }
}
