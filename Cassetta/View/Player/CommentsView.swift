//
//  CommentsView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI

struct CommentsView: View {
    @State  var input: String = ""
    
    var body: some View {
        VStack {
            HStack{
                CustomTextField(text: $input, placeholder: Text("Comment..."), imageName: "paperplane.fill", allLowerCase: false)
                
                Text("Send")
            }
            .frame(height: 40.0)
            .padding([.bottom, .trailing, .top])
            .background(Color("CassettaTan").opacity(0.2))
            
            ScrollView{
                Group{
                    LazyVStack(spacing: 8){
                        ForEach(0 ..< 20) { _ in
                            CommentCell()
                        }
                    }
                    .padding(.top)
                }
                
                .padding(.horizontal)
                .onTapGesture {
                    //placeholder to make the scrollview work for whatever reason
                }
            }
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(input: "comment..")
    }
}
