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
                    //News
                    NavigationLink {
                       // Feed(viewModel: FeedViewModel())
                        Text("Coming")
                    } label: {
                        CategoryCell(categoryTitle: "News", cetegoryEmoji: "📰")
                            .foregroundColor(Color(UIColor.label))
                    }
                    
                    //Tech
                    NavigationLink {
                       // Feed(viewModel: FeedViewModel())
                        Text("Coming")
                    } label: {
                        CategoryCell(categoryTitle: "Tech", cetegoryEmoji: "💻")
                            .foregroundColor(Color(UIColor.label))
                    }
                    
                    
                    //Crypto
                    NavigationLink {
                        //Feed(viewModel: FeedViewModel())
                        Text("Coming")
                    } label: {
                        CategoryCell(categoryTitle: "Crypto", cetegoryEmoji: "💰")
                            .foregroundColor(Color(UIColor.label))
                    }
                    //Sports
                    NavigationLink {
                      //  Feed(viewModel: FeedViewModel())
                        Text("Coming")
                    } label: {
                        CategoryCell(categoryTitle: "Sports", cetegoryEmoji: "🏀")
                            .foregroundColor(Color(UIColor.label))
                    }
                    //Tv & Media
                    NavigationLink {
                       // Feed(viewModel: FeedViewModel())
                        Text("Coming")
                    } label: {
                        CategoryCell(categoryTitle: "TV & Media", cetegoryEmoji: "📺")
                            .foregroundColor(Color(UIColor.label))
                    }
                    //Career
                    NavigationLink {
                        //Feed(viewModel: FeedViewModel())
                        Text("Coming")
                    } label: {
                        CategoryCell(categoryTitle: "Career", cetegoryEmoji: "👩‍🔬")
                            .foregroundColor(Color(UIColor.label))
                    }

                }
                
                
                
//                Group{
//                    CategoryCell(categoryTitle: "Personal Growth", cetegoryEmoji: "🌷")
//
//                    CategoryCell(categoryTitle: "Fashion & Beauty", cetegoryEmoji: "💃")
//
//                    CategoryCell(categoryTitle: "Art", cetegoryEmoji: "🎨")
//
//                    CategoryCell(categoryTitle: "Music", cetegoryEmoji: "🎵")
//
//                    CategoryCell(categoryTitle: "Food", cetegoryEmoji: "🥪")
//
//                    CategoryCell(categoryTitle: "Travel", cetegoryEmoji: "✈️")
//                }
                
                
                
            }
            .padding(.horizontal, 4)
            .padding(.top)
        }
        
    }
}

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView()
    }
}
