//
//  ContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/25/22.
//

import SwiftUI
import MinimizableView

struct ContentPlayerView: View {
    
    var safeArea = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }?.safeAreaInsets
    
    @EnvironmentObject var miniHandler: MinimizableViewHandler
    // Volume Slider...
    @State var volume : CGFloat = 0
    
    var animationNamespaceId: Namespace.ID
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack(alignment: .center, spacing: 0) {
                //TopBarSection
                HStack{
                    //button and capsule stack
                    HStack{
                        Button {
                            self.miniHandler.minimize()
                        } label: {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Capsule()
                            .fill(Color.gray)
                            .frame(width: 40, height: 5)
                    }
                    .frame(width: UIScreen.screenWidth / 1.8)
                    .padding(.top)
                    
                    Spacer()
                }
                .padding(.top, safeArea?.top ?? 0)
                .opacity(self.miniHandler.isMinimized == false ? 1 : 0)
                //Hide on MiniPlayer
                .frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0)
                
                
                
                
                
                Spacer()
                
                //The Image Section
                HStack(spacing: 15){
                    
                    if miniHandler.isMinimized == false {Spacer(minLength: 0)}
                    
                    Image("GenericImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: self.imageSize(proxy: proxy), height: self.imageSize(proxy: proxy))
                        .cornerRadius(15)
                    
                    
                    
                    if miniHandler.isMinimized{
                        
                        self.minimizedControls
                    } else {
                        Spacer(minLength: 0)
                    }
                }
                .padding(.horizontal)
                
                //The Controls
                self.expandedControls
                
                Spacer()
                
                
            }
            .onAppear {
                
                print("appearing & presenting")
                
                
                self.miniHandler.onDismissal = {
                    print("dismissing")
                }
                
                self.miniHandler.onExpansion = {
                    
                    print("expanding")
                }
                
                self.miniHandler.onMinimization = {
                    print("contracting")
                }
                
            }
            
        }
        .transition(AnyTransition.move(edge: .bottom))
        
        
    }
    
    var expandedControls: some View {
        VStack(spacing: 15){
            
            Spacer(minLength: 0)
            
            HStack{
                Spacer(minLength: 0)
                Text("Mui Mui")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .matchedGeometryEffect(id: "Singer", in: animationNamespaceId)
                // .padding(.top, 10)
                
                Spacer(minLength: 0)
                
            }
            .padding()
            .padding(.top,20)
            
            
            
            // Stop Button...
            
            Button(action: {}) {
                
                Image(systemName: "stop.fill")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
            }
            .padding()
            
            Spacer(minLength: 0)
            
            //Volume section
            HStack(spacing: 15){
                
                Image(systemName: "speaker.fill")
                
                Slider(value: $volume)
                
                Image(systemName: "speaker.wave.2.fill")
            }
            .padding()
            .padding(.bottom, safeArea?.bottom == 0 ? 15 : safeArea?.bottom)
        }
        .frame(height: self.miniHandler.isMinimized ? 0 : nil)
        .opacity(self.miniHandler.isMinimized ? 0 : 1)
    }//
    
    
    //The MiniPlayer Controls
    var minimizedControls: some View {
        Group {
            VStack(alignment: .leading) {
                Text("Mui Mui")
                    .font(.title2)
                    .fontWeight(.bold)
                    .fixedSize(horizontal: true, vertical: false)
                    .matchedGeometryEffect(id: "Singer", in: animationNamespaceId)
                
                Text("emBARKation")
                    .fontWeight(.bold)
                    .fixedSize(horizontal: true, vertical: false)
                    .matchedGeometryEffect(id: "Song", in: animationNamespaceId)
                
                
            }
            
            Spacer(minLength: 0)
            
            Button(action: {}, label: {
                
                Image(systemName: "play.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
                    
            })
            
            Button(action: {
                self.miniHandler.dismiss()
            }, label: {
                
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.primary)
                    
            })
            .padding()
            .background(Color.clear)
        }
    }
    
    
    
    // square shaped, so we only need the edge length
    func imageSize(proxy: GeometryProxy)->CGFloat {
        if miniHandler.isMinimized {
            return 55 + abs(self.miniHandler.draggedOffsetY) / 2
        } else {
            return proxy.size.height * 0.33
        }
        
    }
}

struct ContentPlayerView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ContentPlayerView( animationNamespaceId: namespace).environmentObject(MinimizableViewHandler())
    }
}
