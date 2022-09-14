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
    
    var body: some View {
        
        ScrollView{
            //search bar
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
