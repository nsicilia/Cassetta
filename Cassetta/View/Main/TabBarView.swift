//
//  TabBarView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI
import MinimizableView
import Combine


struct TabBarView: View {
    
    let user: User
    
    @ObservedObject var miniHandler: MinimizableViewHandler = MinimizableViewHandler()
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTabIndex: Int = 0
    @GestureState var dragOffset = CGSize.zero
    @Namespace var namespace
        
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    init(user: User) {
        self.user = user
        
        //Make the navigation bar trasparent
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()

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
                    //RecordPostView()
                }
                .tabItem {
                    Image("justchecking")
                        
                }
                
                
                
                //Notification
                NavigationView{
                    NotificationsView()
                        .navigationTitle("Notifications")
//                        .navigationBarTitleDisplayMode(.inline)
//                        .accentColor(.black)
                }
                .tabItem {
                    Image("HeartImage")
                }
                
                
                //Profile
                NavigationView{
                    ProfileView(user: user)
                        .toolbar {
                            Menu {
                                Text("Settings")

                                Text("coming soon")
                                
                                //Log out button
                                Button {
                                    viewModel.signout()
                                } label: {
                                    Text("Logout").foregroundColor(.black)
                                }

                            } label: {
                                Label("More Settings", systemImage: "gearshape")
                                    .foregroundColor(.black)
                            }
                            
                        }
                }
                .tabItem {
                    Image("ProfileImage")
                }
                
                //All tabs end
                
            }
            .background(Color(.secondarySystemFill))
            .statusBar(hidden: self.miniHandler.isPresented && self.miniHandler.isMinimized == false)
            .minimizableView(content: {PlayerView(animationNamespaceId: self.namespace)},
              compactView: {
                MiniPlayerView()  // replace EmptyView() by CompactViewExample() to see the a different approach for the compact view
            }, backgroundView: {
                self.backgroundView()},
                dragOffset: $dragOffset,
                dragUpdating: { (value, state, _) in
                    state = value.translation
                    self.dragUpdated(value: value)

            }, dragOnChanged: { (value) in
       
            },
                dragOnEnded: { (value) in
                self.dragOnEnded(value: value)
            }, geometry: proxy, settings: MiniSettings(minimizedHeight: 75))
            .environmentObject(self.miniHandler)
            
        }//GeometryReader
        
    }
    
    
    func backgroundView() -> some View {
        VStack(spacing: 0){
            Color.white.ignoresSafeArea()
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
    
    
    func dragUpdated(value: DragGesture.Value) {
        
        if self.miniHandler.isMinimized == false && value.translation.height > 0   { // expanded state
            withAnimation(.spring(response: 0)) {
                self.miniHandler.draggedOffsetY = value.translation.height  // divide by a factor > 1 for more "inertia"
            }
            
        } else if self.miniHandler.isMinimized && value.translation.height < 0   {// minimized state
            if self.miniHandler.draggedOffsetY >= -60 {
                withAnimation(.spring(response: 0)) {
                    self.miniHandler.draggedOffsetY = value.translation.height // divide by a factor > 1 for more "inertia"
                }
            }
            
        }
    }
    
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
        TabBarView(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton"))
    }
}
