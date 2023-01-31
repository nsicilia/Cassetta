//
//  SearchView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/22.
//

import SwiftUI
import Firebase

struct SearchView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    
    //@ObservedObject var viewModel = SearchViewModel()
    @ObservedObject var viewModel: SearchViewModel
    
    //For the LNPopup & Playerview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    @Binding var PlayingPost: Post?
    
    
    
    var body: some View {
        
        ZStack {
            
            Color("CassettaTan").ignoresSafeArea()
            
            ScrollView(showsIndicators: false){
                //search bar
                SearchBar(text: $searchText, isEditing: $inSearchMode)
                    .padding()
                
                
                //grid view/ user list view
                ZStack{
                    if inSearchMode {
                        UserListView(viewModel: viewModel, searchText: $searchText, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, PlayingPost: $PlayingPost)
                        
                    } else {
                        
                        //Default view
                        VStack{
                            HighlightsView()
                                .padding(.bottom)
                            
                            CategoryGridView()
                        }
                        
                    }
                }
                
            }
        }
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(), isPopupBarPresented: .constant(false), isPopupOpen: .constant(true), PlayingPost: .constant(Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!")))
    }
}
