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
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack {
                ForEach(1...15, id: \.self) { count in
                    Card()
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
        Feed()
    }
}
