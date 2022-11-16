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
                
                
                //The miniplayer
                HStack(spacing: 15) {
                    //The miniPlayer and main image
                    Image("GenericImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: !self.miniHandler.isMinimized ? 0 : 35, height: !self.miniHandler.isMinimized ? 0 : 35)
                        .cornerRadius(5)
                    
                    //The MiniPlayer info & buttons
                    if self.miniHandler.isMinimized{
                        
                        //MiniPlayer Text
                        VStack(alignment: .leading){
                            Text("The DIFFERENCE between the 5 boroughs (are the STEREOTYPES true)?")
                                //.font(.system(size: 12, .semibold))
                                .fontWeight(.bold)
                                .matchedGeometryEffect(id: "Label", in: animationNamespaceId)
                            
                            Text("Jessica Johnson")
                        }
                        
                        Spacer(minLength: 0)
                        //The play button
                        Button {/*todo*/} label: {
                            Image(systemName: "play.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                                .frame(width: 35.0, height: 35.0)
                        }
                        //The fast foward button
                        Button {/*todo*/
                            self.miniHandler.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .foregroundColor(.primary)
                                .frame(width: 35.0, height: 35.0)
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
            .frame(maxHeight: !self.miniHandler.isMinimized ? .infinity : 65)
            .background(
                VStack(spacing: 0) {
                    BlurView(style: .systemChromeMaterial)
                    Divider()
                }
                    .onTapGesture {
                        withAnimation(.spring()){self.miniHandler.isMinimized.toggle()}
                    }
            )
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
            if value.translation.height > height{
                self.miniHandler.isMinimized.toggle()
            }
            offset = 0
        }
    }
    
}

struct ContentPlayerView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        VStack{
            Spacer()
            ContentPlayerView( animationNamespaceId: namespace).environmentObject(MinimizableViewHandler())
        }
    }
}
