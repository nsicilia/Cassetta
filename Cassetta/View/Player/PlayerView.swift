//
//  PlayerView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/24/22.
//

import SwiftUI
import MinimizableView

struct PlayerView: View {
    
    @EnvironmentObject var miniHandler: MinimizableViewHandler
    
    var animation: Namespace.ID
    @Binding var expand: Bool
    var height = UIScreen.main.bounds.height / 3
    //safeArea
    //var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    var safeArea = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }?.safeAreaInsets
    //Volume Slider
    @State var volume: CGFloat = 0
    //Gesture Offset
    @State var offset: CGFloat = 0
    
    var text: CGFloat = 5
    
    
    
    var body: some View {
        
        //The main expanding/contracting body
        
        VStack {
            
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top, expand ? safeArea?.top : 0)
                .padding(.vertical, expand ? 20 : 0)
            
            //The miniplayer
            HStack(spacing: 15) {
                //The miniPlayer and main image
                Image("GenericImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: expand ? 0 : 50, height: expand ? 0 : 50)
                    .cornerRadius(15)
                
                //The MiniPlayer info & buttons
                if !expand{
                    //MiniPlayer Text
                    Text("Lady Gaga")
                        .font(.title2)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                    
                    Spacer(minLength: 0)
                    //The play button
                    Button {/*todo*/} label: {
                        Image(systemName: "play.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    //The fast foward button
                    Button {/*todo*/} label: {
                        Image(systemName: "forward.fill")
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
                    .frame(width: expand ? height : 0, height: expand ? height : 0)
                    .cornerRadius(15)
                
                //The bottom info view
                LazyVStack(spacing: 15){
                    
                    Text("The DIFFERENCE between the 5 boroughs (are the STEREOTYPES true)?")
                        .font(.title)
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                        .padding([.horizontal, .top], 32)
                        .matchedGeometryEffect(id: "Label", in: animation)
                    
                    ForEach(0 ... 20, id: \.self) { _ in
                        Image("GenericImage")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
                //this will have a stretch effect
                .frame(height: expand ? nil : 0)
                .opacity(expand ? 1 : 0)
                
            }
            
        }//main vstack end
        
        //expands to full screen when clicked
        .frame(maxHeight: expand ? .infinity : 80)
        .background(
            VStack(spacing: 0) {
                BlurView()
                Divider()
            }
                .onTapGesture {
                    withAnimation(.spring()){expand = true}
                }
        )
        //moving the miniplayer above the tabbar
        //tabbar height is 49
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchaged(value:)) )
        .ignoresSafeArea()
        
    }
    
    
    func onchaged(value: DragGesture.Value){
        //only allowing when its expanded
        if value.translation.height > 0 && expand{
            offset = value.translation.height
        }
    }
    func onended(value: DragGesture.Value){
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.9)){
            //if value is > than height / 3 then closing view
            if value.translation.height > height{
                expand = false
            }
            offset = 0
        }
    }
    
    
}

struct PlayerView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        PlayerView(animation: namespace, expand: .constant(true))
    }
}
