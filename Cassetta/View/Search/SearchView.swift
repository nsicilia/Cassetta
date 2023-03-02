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
    
    //Search View Model initialized
    @StateObject var viewModel = SearchViewModel()
    
    //For the LNPopup & Playerview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    
    //Test
    @ObservedObject var postViewModel: PostViewModel
    
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
                        UserListView(viewModel: viewModel, searchText: $searchText, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
                        
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
        SearchView(viewModel: SearchViewModel(), isPopupBarPresented: .constant(false), isPopupOpen: .constant(true), postViewModel: PostViewModel())
    }
}
