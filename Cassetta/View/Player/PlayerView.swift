//
//  PlayerView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/24/22.
//

import SwiftUI
import MinimizableView

struct PlayerView: View {
    
    var safeArea = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }?.safeAreaInsets
    
   // @EnvironmentObject var miniHandler: MinimizableViewHandler
    // Volume Slider...
    //@State var volume : CGFloat = 0
    
    @State var currentTab: Int = 0
    
   // var animationNamespaceId: Namespace.ID
    
    var body: some View {
        //GeometryReader { proxy in
            
            VStack(alignment: .center, spacing: 0) {
                
                VStack {
//
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 40, height: 5)
                        .padding(.top, 10)
//
//                    HStack {
//
//                        Button(action: {
//                            self.miniHandler.minimize()
//                        }) {
//                            Image(systemName: "chevron.down.circle").font(.system(size: 23)).foregroundColor(.secondary)
//                        }.padding(.horizontal, 10)
//                            .frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0)
//
//                        Spacer()
//
//                        Capsule()
//                            .fill(Color.gray)
//                            .frame(width: 60, height: 5)
//
//                        Spacer()
//
//                        Button(action: {
//                            self.miniHandler.dismiss()
//                        }) {
//                            Image(systemName: "xmark.circle").font(.system(size: 23)).foregroundColor(.secondary)
//                        }.padding(.trailing, 10)
//                            .frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0)
//
                    }
//
//                    .frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0)
//                }.frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0).opacity(self.miniHandler.isMinimized ? 0 : 1)
                
                
                Spacer()
                
            
                Group{
                    TabView(selection: $currentTab) {
                        
                        PlayerContentView().tag(0)
                        
                        CommentsView().tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
//                    .frame(height: self.miniHandler.isMinimized ? 0 : nil)
//                    .opacity(self.miniHandler.isMinimized ? 0 : 1)
                }
                .onTapGesture {
                    //placeholder to make the scrollview work for whatever reason
                }
                
                
                BottomControlsView()
//                    .frame(height: self.miniHandler.isMinimized ? 0 : nil)
//                    .opacity(self.miniHandler.isMinimized ? 0 : 1)
                
                Spacer()
                
                
            }
            
       // }.transition(AnyTransition.move(edge: .bottom))
        
        
    }
    
    
}

struct PlayerView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlayerView().environmentObject(MinimizableViewHandler())
    }
}

