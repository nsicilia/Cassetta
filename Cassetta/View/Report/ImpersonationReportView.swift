//
//  ImpersonationReportView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/26/23.
//

import SwiftUI

struct ImpersonationReportView: View {
    @State private var reportTextplaceholer = "@username \n Full Name"
    @State var reportText: String = ""
    
    var body: some View {

            VStack{
                Text("Report")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)
                
                Text("Who are they pretending to be?")
                    .font(.headline)
                    .bold()
                
                Text("Please provide the username and full name of the person they are impersonating.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding([.leading, .trailing], 16)
                    .padding(.top, 8)
                
                TextField("@username \n Full Name", text: $reportText, axis: .vertical)
                    .lineLimit(4...)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .padding()
                
                
                // Gesture overlay to capture taps in the empty space
                GeometryReader { _ in
                    EmptyView()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    UIApplication.shared.endEdit()
                }
                
                
                
                Button(action: {}, label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color("CassettaOrange"))
                        .cornerRadius(8)
                        
                    
                })
                
                
            }
        .onTapGesture {
            UIApplication.shared.endEdit()
        }
    }
}

#Preview {
    ImpersonationReportView()
}
