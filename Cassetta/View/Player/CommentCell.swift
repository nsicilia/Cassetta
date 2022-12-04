//
//  CommentCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/2/22.
//

import SwiftUI

struct CommentCell: View {
    @State private var showPostImage = true
    
    var body: some View {
        HStack(alignment: .top) {
            //Image
            Image("GenericUser")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            //Name + Comment
            VStack(alignment: .leading){
                Text("Jessica")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend nibh et velit euismod, et ultrices ligula egestas.")
                    .font(.system(size: 15))
                    .padding(.bottom)
                
                HStack{
                    Button {
                        //todo
                    } label: {
                        Image(systemName: "hand.thumbsup")
                    }
                    
                    Spacer()
                    
                    Button {
                        //todo
                    } label: {
                        Image(systemName: "hand.thumbsdown")
                    }
                    
                    Spacer()
                    
                    Button {
                        //todo
                    } label: {
                        Image(systemName: "text.bubble")
                    }

                }
                .frame(width: UIScreen.screenWidth / 3)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(15.0)
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("CassettaTan").edgesIgnoringSafeArea(.all)
            CommentCell()
            
        }
    }
}
