//
//  TabBarView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import Combine
import Kingfisher
import LNPopupUI
import SwiftUI

struct TabBarView: View {
    let user: User

    @EnvironmentObject var viewModel: AuthViewModel

    @ObservedObject var feedViewModel = FeedViewModel(config: .random)

    /// Creates the active status of the popupbar, false ill terminate the view
    @State var isPopupBarPresented = false
    /// Determines if the pop up is showing or minimized
    @State var isPopupOpen = true

    @State private var showPopover = false

    /// Value of the currently selected tab
    @State var selectedTab = 1

    // Current post
    @ObservedObject var postViewModel = PostViewModel()

    // The nav profile status of post
    @State var showPosterProfile = false

    init(user: User) {
        self.user = user

        // Make the navigation bar trasparent
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()

        UITabBar.appearance().unselectedItemTintColor = .black
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                TabView(selection: $selectedTab) {
                    // MARK: Home View

                    NavigationView {
                        VStack {
                            if let postUser = postViewModel.user {
                                NavigationLink(destination: ProfileView(user: postUser, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel), isActive: $showPosterProfile) { EmptyView() }
                            }

                            Feed(viewModel: feedViewModel, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, noPostDefault: false, postViewModel: postViewModel)
                        }
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

                    // MARK: Search View

                    NavigationView {
                        SearchView(isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
                            .navigationTitle("Search")
                            .navigationBarTitleDisplayMode(.inline)
                            .accentColor(.black)
                    }
                    .tabItem {
                        Image("SearchImage")
                    }
                    .tag(2)

                    // MARK: Upload View

                    Image(systemName: "mic")
                        .onTapGesture {
                            self.showPopover = true
                        }
                        .tabItem {
                            Image("AddImage")
                        }
                        .tag(3)

                    // MARK: Notification View

                    NavigationView {
                        NotificationsView(isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
                            .navigationTitle("Notifications")
                    }
                    .tabItem {
                        Image("HeartImage")
                    }
                    .tag(4)

                    // MARK: Profile View

                    NavigationView {
                        ProfileView(user: user, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(destination: SettingsView(authView: viewModel, user: user)) {
                                        Label("Settings", systemImage: "gearshape")
                                    }
                                }
                            }
                    }
                    .tabItem {
                        Image("ProfileImage")
                    }
                    .tag(5)

                    // All tabs end
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
        .popup(isBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen) {
            if postViewModel.currentPost != nil {
                PlayerView(isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel, showPosterProfile: $showPosterProfile)
            }
        }
        .popupInteractionStyle(.drag)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(user: User(username: "name", email: "email@email.com", profileImageURL: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", fullname: "Jane Doeinton"))
            .environmentObject(AuthViewModel())
    }
}


