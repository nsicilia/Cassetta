//
//  TabBarView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI
import MinimizableView


struct TabBarView: View {
    
    @ObservedObject var miniHandler: MinimizableViewHandler = MinimizableViewHandler()
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTabIndex: Int = 0
    @GestureState var dragOffset = CGSize.zero
    @Namespace var namespace
    
    
    init(){
        //Make the navigation bar trasparent
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        //Make the TabBar white and not trasparent
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().isTranslucent = true
//        UITabBar.appearance().backgroundColor = .white
        
        //Makes unselected icons black
        UITabBar.appearance().unselectedItemTintColor = .black

    }
    

    var body: some View {

        GeometryReader { proxy in
            
            TabView {
                //Home
                NavigationView{
                    Feed()
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Image("BlackCassettaLogo")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFill()
                                    .frame(height: 40)
                                    .foregroundColor(Color("CassettaBlack"))
                                
                            }
                            
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Image("MessageImage")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    
                        .background(Color("CassettaTan"))
                    
                }
                .tabItem {
                    Image("HomeImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .padding(.top, 10)
                }
                
                
                
                //Search
                NavigationView{
                    SearchView()
                        .navigationTitle("Search")
                        .navigationBarTitleDisplayMode(.inline)
                        .accentColor(.black)
                }
                .tabItem {
                    Image("SearchImage")
                    
                }
                
                
                //Upload
                NavigationView{
                    UploadPostView()
                }
                .tabItem {
                    Image("AddImage")
                }
                
                
                //Notification
                NavigationView{
                    NotificationsView()
                        .navigationTitle("Notifications")
                        .navigationBarTitleDisplayMode(.inline)
                        .accentColor(.black)
                }
                .tabItem {
                    Image("HeartImage")
                        .cornerRadius(12.0)
                        .shadow(color: Color.black.opacity(0.2), radius: 8)
                }
                
                
                //Profile
                NavigationView{
                    UserProfile()
                        .toolbar {
                            //Label("More Settings", systemImage: "ellipsis")
                            
                            Menu {
                                Text("hat")
                                Text("cat")
                                Text("bat")
                            } label: {
                                Label("More Settings", systemImage: "ellipsis")
                            }
                        }
                }
                .tabItem {
                    Image("ProfileImage")
                }
                
                
                
            }
            
            .background(Color(.secondarySystemFill))
            .statusBar(hidden: self.miniHandler.isPresented && self.miniHandler.isMinimized == false)
            .minimizableView(content: {ContentPlayerView(animationNamespaceId: self.namespace)},
                             compactView: {
                EmptyView()  // replace EmptyView() by CompactViewExample() to see the a different approach for the compact view
            }, backgroundView: {
                self.backgroundView()},
                             dragOffset: $dragOffset,
                             dragUpdating: { (value, state, _) in
                state = value.translation
               // self.dragUpdated(value: value)
                
            }, dragOnChanged: { (value) in
                
            },
                             dragOnEnded: { (value) in
                self.dragOnEnded(value: value)
            }, geometry: proxy, settings: MiniSettings(minimizedHeight: 75))
            .environmentObject(self.miniHandler)
            
        }
        
    }
    
    func backgroundView() -> some View {
        VStack(spacing: 0){
            BlurView(style: .systemChromeMaterial)
            if self.miniHandler.isMinimized {
                Divider()
            }
        }.cornerRadius(self.miniHandler.isMinimized ? 0 : 20)
            .shadow(color: .gray.opacity(self.colorScheme == .light ? 0.5 : 0), radius: 5, x: 0, y: -5)
        .onTapGesture(perform: {
            if self.miniHandler.isMinimized {
                self.miniHandler.expand()
                //alternatively, override the default animation. self.miniHandler.expand(animation: Animation)
            }
        })
    }
    
    
//    func dragUpdated(value: DragGesture.Value) {
//        
//        if self.miniHandler.isMinimized == false && value.translation.height > 0   { // expanded state
//            withAnimation(.spring(response: 0)) {
//                self.miniHandler.draggedOffsetY = value.translation.height  // divide by a factor > 1 for more "inertia"
//            }
//            
//            
//        } else if self.miniHandler.isMinimized && value.translation.height < 0   {// minimized state
//            if self.miniHandler.draggedOffsetY >= -60 {
//                withAnimation(.spring(response: 0)) {
//                    self.miniHandler.draggedOffsetY = value.translation.height // divide by a factor > 1 for more "inertia"
//                }
//            }
//            
//        }
//    }
    
    func dragOnEnded(value: DragGesture.Value) {
        
        if self.miniHandler.isMinimized == false && value.translation.height > 90  {
            self.miniHandler.minimize()

        } else if self.miniHandler.isMinimized &&  value.translation.height <= -60 {
                  self.miniHandler.expand()
        }
        withAnimation(.spring()) {
            self.miniHandler.draggedOffsetY = 0
        }
  

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
