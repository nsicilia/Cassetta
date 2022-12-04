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
    
    @EnvironmentObject var miniHandler: MinimizableViewHandler
    // Volume Slider...
    @State var volume : CGFloat = 0
    
    @State var currentTab: Int = 0
    
    var animationNamespaceId: Namespace.ID
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack(alignment: .center, spacing: 0) {
                
                VStack {
                    
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 40, height: 5)
                        .padding(.top, safeArea?.top  ?? 0)
                    
                    HStack {
                        
                        Button(action: {
                            self.miniHandler.minimize()
                        }) {
                            Image(systemName: "chevron.down.circle").font(.system(size: 20)).foregroundColor(.primary)
                        }.padding(.horizontal, 10)
                            .frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0)
                        
                        Spacer()
                        
                        Capsule()
                            .fill(Color.gray)
                            .frame(width: 60, height: 5)
                        
                        Spacer()
                        
                        Button(action: {
                            self.miniHandler.dismiss()
                        }) {
                            Image(systemName: "xmark.circle").font(.system(size: 20)).foregroundColor(.primary)
                        }.padding(.trailing, 10)
                            .frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0)
                        
                    }.frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0)
                }.frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0).opacity(self.miniHandler.isMinimized ? 0 : 1)
                
                
                Spacer()
                
                
                // ScrollView{
                Group{
                    TabView(selection: $currentTab) {
                        
                        PlayerContentView().tag(0)
                        
                        CommentsView().tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: self.miniHandler.isMinimized ? 0 : nil)
                    .opacity(self.miniHandler.isMinimized ? 0 : 1)
                }
                .onTapGesture {
                    //placeholder to make the scrollview work for whatever reason
                }
                BottomControlsView()
                    .frame(height: self.miniHandler.isMinimized ? 0 : nil)
                    .opacity(self.miniHandler.isMinimized ? 0 : 1)
                
                Spacer()
                
                
            }
            
        }.transition(AnyTransition.move(edge: .bottom))
        
        
    }
    
    
}

struct PlayerView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        PlayerView( animationNamespaceId: namespace).environmentObject(MinimizableViewHandler())
    }
}

