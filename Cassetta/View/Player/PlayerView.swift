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

    var animationNamespaceId: Namespace.ID

    var body: some View {
        GeometryReader { proxy in
       
                VStack(alignment: .center, spacing: 0) {
       
                        VStack {
                            
                            Capsule()
                                .fill(Color.gray)
                              //  .frame(width: self.miniHandler.isMinimized == false ? 40 : 0, height: self.miniHandler.isMinimized == false ? 5 : 0)
                                .frame(width: 40, height: 5)
                               // .opacity(self.miniHandler.isMinimized == false ? 1 : 0)
                                .padding(.top, safeArea?.top  ?? 0)

                            HStack {
                                
                                Button(action: {
                                    self.miniHandler.minimize()
                                }) {
                                    Image(systemName: "chevron.down.circle").font(.system(size: 20)).foregroundColor(.primary)
                                }.padding(.horizontal, 10)
                                .frame(width: self.miniHandler.isMinimized == false ? nil : 0, height: self.miniHandler.isMinimized == false ? nil : 0)
                                
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

            
                    ScrollView{
                        
                        Group{
                            
                            Image("GenericImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: self.miniHandler.isMinimized ? 0 : nil)
                                .opacity(self.miniHandler.isMinimized ? 0 : 1)
                                .cornerRadius(5)
                            
                        Text("The DIFFERENCE between the 5 boroughs (are the STEREOTYPES true)?")
                            .font(.title)
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                            .padding([.horizontal, .top], 32)
                            .matchedGeometryEffect(id: "MainTitle", in: animationNamespaceId)
                            .frame(height: self.miniHandler.isMinimized ? 0 : nil)
                            .opacity(self.miniHandler.isMinimized ? 0 : 1)
                            
                            
                            HStack{
                                
                                Button(action: {
                                    //todo
                                }, label: {
                                    HStack{
                                        Text("13k")
                                        Text("💬")
                                    }
                                })
                                
                                Spacer()
                                
                                Button(action: {
                                    //todo
                                }, label: {
                                    Image(systemName: "heart")
                                })
                                
                                Spacer()
                                
                                Button(action: {
                                    //todo
                                }, label: {
                                    Image(systemName: "hand.thumbsdown")
                                })

                                
                            }
                            .padding()
                            .frame(width: UIScreen.screenWidth / 2 )
                        
                        LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
//                            Section(header: headerView(0)) {
                                self.expandedControls
                            //}
                            
                        }
                            
                    }
                        .padding(.horizontal)
                        .onTapGesture {
                            //placeholder to make the scrollview work for whatever reason
                        }
                        
                    }//Scroll View
                    .frame(height: self.miniHandler.isMinimized ? 0 : nil)
                    .opacity(self.miniHandler.isMinimized ? 0 : 1)
                    
                    headerView(0)
                    Spacer()


                }

        }.transition(AnyTransition.move(edge: .bottom))
      

    }
    
    var expandedControls: some View {
        VStack(spacing: 15){
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                .padding([.horizontal, .top], 32)
            
            Image("GenericImage")
                .resizable()
                .scaledToFit()
                .padding([.horizontal, .top], 32)
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                .padding([.horizontal, .top], 32)
            

        }
        .frame(height: self.miniHandler.isMinimized ? 0 : nil)
        .opacity(self.miniHandler.isMinimized ? 0 : 1)
    }
    
    
    
    private func headerView(_ index: Int) -> some View {
        ZStack{
            
            HStack{
                Button {
                    //todo
                } label: {
                    Image(systemName: "gobackward.15")
                        .font(.title)
                        .foregroundColor(.black)
                }

                
                Spacer()
                Button {
                    //todo
                } label: {
                    Image(systemName: "play.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                Spacer()
                Button {
                    //todo
                } label: {
                    Image(systemName: "goforward.15")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .frame(width: UIScreen.screenWidth / 2.5)
            .padding(.vertical)
            .padding()
            .font(.largeTitle)
            .frame(maxWidth: .infinity)
            
        }
        .background(.white)
        .frame(height: self.miniHandler.isMinimized ? 0 : nil)
        .opacity(self.miniHandler.isMinimized ? 0 : 1)
    }
}

struct PlayerView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        PlayerView( animationNamespaceId: namespace).environmentObject(MinimizableViewHandler())
    }
}

