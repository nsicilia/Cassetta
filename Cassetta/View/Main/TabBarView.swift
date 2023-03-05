//
//  TabBarView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI
import Combine
import LNPopupUI
import Kingfisher

//class PostViewModel: ObservableObject {
//    @Published var playingPost: Post?
//}

struct TabBarView: View {
    
    let user: User
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @ObservedObject var feedViewModel = FeedViewModel(config: .newest)
    
    ///Creates the active status of the popupbar, false ill terminate the view
    @State var isPopupBarPresented = false
    ///Determines if the pop up is showing or minimized
    @State var isPopupOpen = true
    
    @State private var showPopover = false
    
    ///Value of the currently selected tab
    @State var selectedTab = 1
    
   // @State var PlayingPost: Post?
    
   // @State var playerViewPost: Post?
    
    //Test post SOT
    @ObservedObject var postViewModel = PostViewModel()
    
    
    init(user: User) {
        self.user = user
        
        //Make the navigation bar trasparent
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        UITabBar.appearance().unselectedItemTintColor = .black
        
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                TabView(selection: $selectedTab) {
                    
                    
                    
                    //MARK: Home View
                    NavigationView{
                        Feed(viewModel: feedViewModel, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen,  postViewModel: postViewModel)
                            .toolbar {
                                ToolbarItemGroup(placement: .navigationBarLeading) {
                                    Image("BlackCassettaLogo")
                                        .resizable()
                                        .renderingMode(.template)
                                        .scaledToFill()
                                        .frame(height: 40)
                                        .foregroundColor(Color("CassettaBlack"))
                                    
                                }
                                
//                                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                                    Image("MessageImage")
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 24, height: 24)
//                                }
                            }
                        
                            .background(Color("CassettaTan"))
                        
                    }
                    .tabItem {
                        Image("HomeImage")
                    }
                    .tag(1)
                    
                    
                    
                    //MARK: Search View
                    NavigationView{
                        //SearchView(isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, PlayingPost: $PlayingPost, postViewModel: postViewModel)
                        SearchView(isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
                            .navigationTitle("Search")
                            .navigationBarTitleDisplayMode(.inline)
                            .accentColor(.black)
                    }
                    .tabItem {
                        Image("SearchImage")
                    }
                    .tag(2)
                    
                    
                    
                    //MARK: Upload View
                    Image(systemName: "mic")
                        .onTapGesture {
                            self.showPopover = true
                        }
                        .tabItem {
                            Image("AddImage")
                        }
                        .tag(3)
                    
                    
                    
                    //MARK: Notification View
                    NavigationView{
                        NotificationsView()
                            .navigationTitle("Notifications")
                    }
                    .tabItem {
                        Image("HeartImage")
                    }
                    .tag(4)
                    
                    
                    
                    //MARK: Profile View
                    NavigationView{
                      //  ProfileView(user: user, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, PlayingPost: $PlayingPost)
                        ProfileView(user: user, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
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
                    .tag(5)
                    
                    //All tabs end
                    
                }
                .onChange(of: selectedTab) { newValue in
                    if newValue == 3 {
                        self.showPopover = true
                    }
                }
            }
            .fullScreenCover(isPresented: $showPopover,
                             onDismiss: {
                self.selectedTab = 1
            }) {
                // Add the content of your popover here
                RecordPostView(audioRecorder: AudioRecorderViewModel(), showStatus: $showPopover)
            }
            
            
        }
        
        .popup(isBarPresented: $isPopupBarPresented , isPopupOpen: $isPopupOpen ) {

            if let post = postViewModel.playingPost{
                
                PlayerView(isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postInfoVM: PostInfoViewModel(post: post), postViewModel: postViewModel)
            }
            
        }
        .popupInteractionStyle(.drag)
//        .onChange(of: postViewModel.playingPost) { newValue in
//
//            isPopupBarPresented = true
//            playerViewPost = newValue
//
//        }
    }
}






struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton"))
    }
}
