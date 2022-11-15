//
//  ContentView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/25/22.
//

import SwiftUI
import MinimizableView

struct ContentPlayerView: View {
    
    var height = UIScreen.main.bounds.height / 3
    @State var offset: CGFloat = 0
    
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
            
            //The main expanding/contracting body
            
            VStack {
                
                Image("LineDownImage")
                   // .fill(Color.gray)
                    .frame(width: !self.miniHandler.isMinimized ? 100 : 0, height: !self.miniHandler.isMinimized ? 4 : 0)
                    .opacity(!self.miniHandler.isMinimized ? 1 : 0)
                    .padding(.top, !self.miniHandler.isMinimized ? safeArea?.top : 0)
                    .padding(.vertical, !self.miniHandler.isMinimized ? 20 : 0)
                
//                Capsule()
//                    .fill(Color.gray)
//                    .frame(width: !self.miniHandler.isMinimized ? 60 : 0, height: !self.miniHandler.isMinimized ? 4 : 0)
//                    .opacity(!self.miniHandler.isMinimized ? 1 : 0)
//                    .padding(.top, !self.miniHandler.isMinimized ? safeArea?.top : 0)
//                    .padding(.vertical, !self.miniHandler.isMinimized ? 20 : 0)
                
                //The miniplayer
                HStack(spacing: 15) {
                    //The miniPlayer and main image
                    Image("GenericImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: !self.miniHandler.isMinimized ? 0 : 50, height: !self.miniHandler.isMinimized ? 0 : 50)
                        .cornerRadius(15)
                    
                    //The MiniPlayer info & buttons
                    if self.miniHandler.isMinimized{
                        //MiniPlayer Text
                        Text("Lady Gaga")
                            .font(.title2)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "Label", in: animationNamespaceId)
                        
                        Spacer(minLength: 0)
                        //The play button
                        Button {/*todo*/} label: {
                            Image(systemName: "play.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        //The fast foward button
                        Button {/*todo*/
                            self.miniHandler.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)
                
                
                ScrollView {
                    //Main image in full size mode
                    Image("GenericImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: !self.miniHandler.isMinimized ? height : 0, height: !self.miniHandler.isMinimized ? height : 0)
                        .cornerRadius(15)
                    
                    //The bottom info view
                    LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                        
                        Text("\(Int.random(in: 0..<6)) The DIFFERENCE between the 5 boroughs (are the STEREOTYPES true)?")
                            .font(.title)
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                            .padding([.horizontal, .top], 32)
                            .matchedGeometryEffect(id: "Label", in: animationNamespaceId)
                        
                        HStack{
                            
                            Image(systemName: "gobackward.15")
                                .font(.title)
                            Spacer()
                            
                            Image(systemName: "play.fill")
                                .font(.title)
                            Spacer()
                            Image(systemName: "goforward.15")
                                .font(.title)
                        }
                        .frame(width: UIScreen.screenWidth / 2.5)
                        .padding(.vertical)
                        
                        
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                            .padding([.horizontal, .top], 32)
                        
                        Image("GenericImage")
                            .resizable()
                            .scaledToFit()
                            .padding([.horizontal, .top], 32)
                            
                        
                    }
                    //this will have a stretch effect
                    .frame(height: !self.miniHandler.isMinimized ? nil : 0)
                    .opacity(!self.miniHandler.isMinimized ? 1 : 0)
                    
                }//ScrollView
                
            }//main vstack end
            
            //expands to full screen when clicked
            .frame(maxHeight: !self.miniHandler.isMinimized ? .infinity : 80)
            .background(
                VStack(spacing: 0) {
                    BlurView(style: .systemChromeMaterial)
                    Divider()
                }
                    .onTapGesture {
                        withAnimation(.spring()){self.miniHandler.isMinimized.toggle()}
                    }
            )
            //moving the miniplayer above the tabbar
            //tabbar height is 49
//            .cornerRadius(self.miniHandler.isMinimized ? 20 : 0)
//            .offset(y: self.miniHandler.isMinimized ? 0 : -48)
//            .offset(y: offset)
            .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchaged(value:)) )
            .ignoresSafeArea()
            

        }
        
        
    }
    
    
    func onchaged(value: DragGesture.Value){
        //only allowing when its expanded
        if value.translation.height > 0 && self.miniHandler.isMinimized{
            offset = value.translation.height
        }
    }
    func onended(value: DragGesture.Value){
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.9)){
            //if value is > than height / 3 then closing view
            if value.translation.height > height / 3 {
                self.miniHandler.isMinimized.toggle()
            }
            offset = 0
        }
    }
    
//    var expandedControls: some View {
//        VStack(spacing: 15){
//
//            Text("How to Become a Cats Influencer in Three Easy Steps")
//                .font(.system(size: 24, weight: .bold))
//                .multilineTextAlignment(.center)
//                .foregroundColor(.primary)
//                .matchedGeometryEffect(id: "Singer", in: animationNamespaceId)
//
//            Text("Jessica Johnson")
//
//            // Stop Button...
//
//            Button(action: {}) {
//
//                Image(systemName: "stop.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(.primary)
//            }
//            .padding()
//
//            Spacer(minLength: 0)
//
//
//        }
//        .padding(.horizontal)
//        .padding(.top)
//        .frame(height: self.miniHandler.isMinimized ? 0 : nil)
//        .opacity(self.miniHandler.isMinimized ? 0 : 1)
//
//    }
    
    
    //The MiniPlayer Controls
//    var minimizedControls: some View {
//        Group {
//            VStack(alignment: .leading) {
//                Text("How to Become a Cats Influencer in Three Easy Steps")
//                    .fontWeight(.bold)
//                    .matchedGeometryEffect(id: "Singer", in: animationNamespaceId)
//
//                Text("Jessica Johnson")
//                    .matchedGeometryEffect(id: "Song", in: animationNamespaceId)
//
//            }
//            .frame(maxWidth: UIScreen.main.bounds.width / 3 )
//
//            Spacer(minLength: 0)
//
//            Button(action: {}, label: {
//
//                Image(systemName: "play.fill")
//                    .font(.title2)
//                    .foregroundColor(.primary)
//
//            })
//            .background(Color.red)
//
//            Button(action: {
//                self.miniHandler.dismiss()
//            }, label: {
//
//                Image(systemName: "xmark")
//                    .font(.title3)
//                    .foregroundColor(.primary)
//                    .frame(width: 44.0)
//                    .background(Color.pink)
//
//            })
//            .padding()
//
//        }
//    }
    
    
    // square shaped, so we only need the edge length
//    func imageSize(proxy: GeometryProxy)->CGFloat {
//        if miniHandler.isMinimized {
//            return 55 + abs(self.miniHandler.draggedOffsetY) / 2
//        } else {
//            return proxy.size.height * 0.33
//        }
//
//    }
    
    
}

struct ContentPlayerView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ContentPlayerView( animationNamespaceId: namespace).environmentObject(MinimizableViewHandler())
    }
}
