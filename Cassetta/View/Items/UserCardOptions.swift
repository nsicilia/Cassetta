//
//  UserCardOptions.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/7/23.
//

import SwiftUI

struct UserCardOptions: View {
    
    @State private var isPresentingConfirm: Bool = false
    
    
    var body: some View {
        HStack{
            Button {
                //todo
            } label: {
                HStack{
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
                .padding(.vertical, 6)
                .padding(.horizontal)
                .background(.white)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("CassettaBorder"), lineWidth: 2)
            )
            }
            
            Spacer()
            
                // Text("Hold to: 🗑️")
//                .contextMenu(menuItems: {
//                    Button {
//                        print("delete button wirked worked")
//                    } label: {
//                        Text("Delete")
//                    }
//
//                })
            Button {
                isPresentingConfirm = true
            } label: {
                Text("🗑️")
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("CassettaBorder"), lineWidth: 2)
                            
                )
                    
            }

//            Button("🗑️", role: .destructive) {
//                  isPresentingConfirm = true
//                }
               .confirmationDialog("Are you sure?",
                 isPresented: $isPresentingConfirm) {
                 Button("Delete this post?", role: .destructive) {
                  // store.deleteAll()
                  }

                } message: {
                    Text("You cannot undo this action")
                  }


            
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct UserCardOptions_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            UserCardOptions()
        }
        .frame(height: UIScreen.screenHeight)
            .background(.gray)
            
    }
}
