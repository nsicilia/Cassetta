//
//  CategoryGridView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/16/22.
//

import SwiftUI
import Firebase

struct CategoryGridView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let categoryData = [
    CategoryData(id: 1, title: "Art", emoji: "🎨"),
    CategoryData(id: 2, title: "ASMR", emoji: "👂"),
    CategoryData(id: 3, title: "Beauty", emoji: "💅"),
    CategoryData(id: 4, title: "Books", emoji: "📚"),
    CategoryData(id: 5, title: "Business", emoji: "📈"),
    CategoryData(id: 6, title: "Career", emoji: "🗃️"),
    CategoryData(id: 7, title: "Celebs", emoji: "📸"),
    CategoryData(id: 8, title: "Comedy", emoji: "🎭"),
    CategoryData(id: 9, title: "Culture", emoji: "🙏"),
    CategoryData(id: 10, title: "Education", emoji: "📓"),
    CategoryData(id: 11, title: "Entertainment", emoji: "📣"),
    CategoryData(id: 12, title: "Fashion", emoji: "👠"),
    CategoryData(id: 13, title: "Finance", emoji: "💵"),
    CategoryData(id: 14, title: "Food", emoji: "🍔"),
    CategoryData(id: 15, title: "Growth", emoji: "🌱"),
    CategoryData(id: 16, title: "Health", emoji: "🩺"),
    CategoryData(id: 17, title: "History", emoji: "📜"),
    CategoryData(id: 18, title: "Language", emoji: "🗣️"),
    CategoryData(id: 19, title: "Lifestyle", emoji: "🏡"),
    CategoryData(id: 20, title: "Music", emoji: "🎵"),
    CategoryData(id: 21, title: "News", emoji: "📰"),
    CategoryData(id: 22, title: "Philosophy", emoji: "💭"),
    CategoryData(id: 23, title: "Relationships", emoji: "❤️"),
    CategoryData(id: 24, title: "Science", emoji: "🧪"),
    CategoryData(id: 25, title: "Sports", emoji: "🏀"),
    CategoryData(id: 26, title: "Tech", emoji: "💻"),
    CategoryData(id: 27, title: "True Crime", emoji: "🔍"),
    CategoryData(id: 28, title: "TV", emoji: "📺"),
    CategoryData(id: 29, title: "Video Games", emoji: "👾")
    ]
    
    //For the LNPopup & Playerview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    
    //@ObservedObject var feedViewModel = FeedViewModel(config: .random)
    
    //Test
    @StateObject var postViewModel: PostViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 22) {
                ForEach(categoryData) { category in
                    
                    NavigationLink {
                        
                        Feed(viewModel: FeedViewModel(config: .category(category.title)), isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
                            .background(Color("CassettaTan"))
                            .background(ignoresSafeAreaEdges: .all)
                        
                    } label: {
                        CategoryCell(categoryTitle: category.title, cetegoryEmoji: category.emoji)
                            .foregroundColor(Color(UIColor.label))
                    }
                    .background(Color("CassettaTan"))
                    .background(ignoresSafeAreaEdges: .all)
                    
                    
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
    static var post = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        CategoryGridView(isPopupBarPresented: .constant(false), isPopupOpen: .constant(true), postViewModel: PostViewModel(post: post))
            .background(Color("CassettaTan"))
    }
}
