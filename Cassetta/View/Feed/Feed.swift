//
//  Feed.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 6/8/22.
//

import SwiftUI
import MinimizableView

struct Feed: View {
    @EnvironmentObject var miniHandler: MinimizableViewHandler
    //The Feed view model
    @ObservedObject var viewModel: FeedViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack {
                ForEach(viewModel.posts) { post in
                    Card(post: post)
                        .padding(.bottom, 12)
                        .onTapGesture {
                            if self.miniHandler.isPresented {
                                self.miniHandler.dismiss()
                            }
                                self.miniHandler.present()
                            
                        }
                }
                
            }
            .padding(.top)
            .background(Color("CassettaTan"))
        }
        //
    }
    
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed( viewModel: FeedViewModel()).environmentObject(MinimizableViewHandler())
    }
}
