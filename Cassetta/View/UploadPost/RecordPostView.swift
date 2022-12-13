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
                
                Spacer()
                
                Text("Stuff")
                
                Spacer()
                
                
                VStack {
                    Text("00:00:00")
                        .font(.system(size: 24))
                        .padding(.bottom)
                    
                    HStack{
                        Spacer()
                        
                        HStack {
                            Button {
                                //todo
                            } label: {
                                Image("UploadAudio")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: UIScreen.screenWidth * 0.001)
                        
                        HStack {
                            Button {
                                //todo
                            } label: {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.red)
                                    .padding(6)
                                    .overlay(Circle().stroke(.black, lineWidth: 4))
                            }
                        }
                        .frame(width: UIScreen.screenWidth * 0.64)
                        
                        Spacer()
                    }
                    
                }
                .padding(.vertical, 40)
            .background(Color("CassettaTan"))
                
                
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        //close the view
                        showStatus.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink {
                        PlayBackPostView(showStatus: $showStatus)
                    } label: {
                        Text("Next")
                            .bold()
                            .frame(width: 80, height: 30)
                            .background(Color("CassettaOrange"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                
            }
        }
    }
}


struct RecordPostView_Previews: PreviewProvider {
    static var previews: some View {
        RecordPostView(showStatus: .constant(true))
    }
}
