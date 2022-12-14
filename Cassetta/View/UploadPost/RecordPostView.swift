//
//  UploadPostView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/3/22.
//

import SwiftUI

struct RecordPostView: View {
    @Binding var showStatus: Bool
    
    //
    @State var fileName = ""
    @State var fileURL: URL = URL(fileURLWithPath: "")
    @State var openfile = false
    
    var body: some View {
        NavigationView {
            VStack{
                
                Spacer()
                
                Text("Stuff")
                Text(fileName)
                
                Spacer()
                
                
                VStack {
                    Text("00:00:00")
                        .font(.system(size: 24))
                        .padding(.bottom)
                    
                    HStack{
                        Spacer()
                        
                        
                        //The Upload a file Button
                        HStack {
                            Button {
                                //todo
                                openfile.toggle()
                            } label: {
                                Image("UploadAudio")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.black)
                            }
                            .fileImporter(isPresented: $openfile, allowedContentTypes: [.audio]) { result in
                                do{
                                    let fileURL = try result.get()
                                    print("THEFILE: \(String(describing: fileURL))")
                                    
                                    self.fileName = fileURL.lastPathComponent
                                    self.fileURL = fileURL
                                }
                                catch{
                                    print("error reading docs\(error.localizedDescription)")
                                }
                            }
                        }
                        .frame(width: UIScreen.screenWidth * 0.001)
                        
                        
                        //Record an audio segment button
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
