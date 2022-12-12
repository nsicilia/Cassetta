//
//  UploadPostView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/22.
//

import SwiftUI

struct RecordPostView: View {
    @Binding var showStatus: Bool
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Button {
                        //todo
                        showStatus.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    
                    NavigationLink {
                       // PlaybackView(showStatus: $showStatus)
                    } label: {
                        Text("Next")
                            .bold()
                            .frame(width: 80, height: 30)
                            .background(.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            
                            
                    }
                    

                }
                .padding()
                
                Spacer()
                
                Text("Stuff")
                
                Spacer()
                
                HStack{
                    Spacer()
                    Circle()
                        .frame(width: 64, height: 64)
                    Spacer()
                }
                .padding(.vertical, 42)
                .background(Color(.gray))
            }
        }
    }
}

struct RecordPostView_Previews: PreviewProvider {
    static var previews: some View {
        RecordPostView(showStatus: .constant(true))
    }
}
