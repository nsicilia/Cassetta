//
//  CustomNumPadView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/22/23.
//

import SwiftUI

struct CustomNumPadView: View {
    @Binding var value: String
    var isVerify : Bool
    
    var rows = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "delete.left"]
    
    var body: some View {
        GeometryReader{reader in
            VStack{
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 15, content: {
                    ForEach(rows, id: \.self){ value in
                        //Button
                        Button(action: {
                            buttonAction(value: value)
                        }, label: {
                            
                            ZStack{
                                if value == "delete.left"{
                                    Image(systemName: value)
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.black)
                                }else{
                                    Text(value)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: getWidth(frame: reader.frame(in: .global)), height: getHeight(frame: reader.frame(in: .global)))
                            .background(Color.white)
                            .cornerRadius(10)
                        })
                        .disabled(value == "" ? true : false)
                    }
                })
                
            }
            
        }
        .padding()
    }
    
    func getWidth(frame: CGRect) -> CGFloat{
        let width = frame.width
        
        let actualWidth = width - 30
        
        return actualWidth / 3
    }
    
    func getHeight(frame: CGRect) -> CGFloat{
        let height = frame.height
        
        let screenHeight = height - 30
        
        return screenHeight / 4
    }
    
    func buttonAction(value: String){
        if value == "delete.left" && self.value != ""{
            self.value.removeLast()
        }else if value != "delete.left"{
            
            if isVerify{
                if self.value.count < 6{
                    self.value.append(value)
                }
            }else{
                if self.value.count < 10{
                    self.value.append(value)
                }
            }
        }
    }
}

#Preview {
    CustomNumPadView(value: .constant(""), isVerify: false)
}
