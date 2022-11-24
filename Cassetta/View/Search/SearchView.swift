//
//  SearchView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/22.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    
    @ObservedObject var viewModel = SearchViewModel()
    
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
                        UserListView(viewModel: viewModel, searchText: $searchText)
                        
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
        SearchView()
    }
}
