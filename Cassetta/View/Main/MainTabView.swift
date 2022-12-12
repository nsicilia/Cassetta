//
//  MainTabView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/12/22.
//

import SwiftUI
import MinimizableView
import Combine

struct MainTabView: View {
    
    //Tab Bar icons
    let tabBarImageNames = ["HomeImage","SearchImage", "plus.app.fill", "HeartImage","ProfileImage"]
    
    let user: User
    //Tracks the selected tab
    @State var selectedIndex = 0
    //Shows or hides the upload view
    @State var showModel = false
    
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
            
        VStack(spacing: 0) {
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $showModel) {
                        RecordPostView(showStatus: $showModel)
                    }
                
                switch selectedIndex {
                    //The Home view
                case 0:
                    NavigationView {
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
                    
                    //Search view
                case 1:
                    NavigationView {
                        SearchView()
                            .navigationTitle("Search")
                            .navigationBarTitleDisplayMode(.inline)
                            .accentColor(.black)
                    }
                    
                    //This is empty because it is the upload button
                case 2:
                    EmptyView()
                    
                    //Navigation view
                case 3:
                    NavigationView {
                        NotificationsView()
                            .navigationTitle("Notifications")
                    }
                    
                    //Profile view
                case 4:
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
                    
                default:
                    NavigationView {
                        Text("Remaining Tabs")
                    }
                    
                }
            }

            
            Divider()
              //  .padding(.bottom, 12)
            
            //The NavigationBar
            HStack{
                ForEach(0..<5){ num in
                    Button {
                        
                        if num == 2{
                            showModel.toggle()
                            return
                        }
                        selectedIndex = num
                        
                    } label: {
                        
                        if num == 2{
                            //The Upload button
                            Spacer()
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 44,weight: .black))
                                .foregroundColor(Color("CassettaOrange"))
                            Spacer()
                        }else {
                            //The non-upload tabs
                            Spacer()
                            Image(tabBarImageNames[num])
                                .font(.system(size: 24,weight: .black))
                                .foregroundColor(selectedIndex == num ? Color(.label) : .gray)
                            Spacer()
                        }
                    }
                    
                }
            }//Navigation Bar
            .padding(.bottom, 32)
        }
        //------------Test---------------
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

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton"))
    }
}
