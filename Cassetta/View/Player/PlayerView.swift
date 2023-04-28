//
//  PlayerView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/24/22.
//

import SwiftUI
import UIKit
import Firebase
import LNPopupUI

struct PlayerView: View {
    
    var safeArea = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }?.safeAreaInsets
    
    
    
    @State var currentTab: Int = 0
    
    //Popupview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    
    //PlayerState
    @State var previewstatus: Bool = true
    @StateObject var audioManager = AudioManager()
    
    //post SOT
    @ObservedObject var postViewModel: PostViewModel
    
    //the post profile nav status
    @Binding var showPosterProfile: Bool
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            VStack {
                Capsule()
                    .fill(Color.white)
                    .frame(width: 40, height: 5)
                    .padding(.top, 10)
                
            }
            
            
            
            Spacer()
            
            
            Group{
                TabView(selection: $currentTab) {
                    
                    PlayerContentView(postViewModel: postViewModel, isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, showPosterProfile: $showPosterProfile).tag(0)
                    
                    CommentsView(post: postViewModel.currentPost! ).tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)
            }
            .onTapGesture {
                //placeholder to make the scrollview work for whatever reason
            }
            
            
            BottomControlsView(audioManager: audioManager)
            
            Spacer()
            
            
        }
        //MARK: Miniview Bar
        //title
        .popupTitle(verbatim: postViewModel.currentPost?.title ?? "Title")
        //image
        .popupImage(
           // Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: post.imageUrl)!)) ?? UIImage(named: "GenericPhotoIcon")!).resizable()
           // Image("DefaultImage").resizable().clipped() as! UIImage
            
            postViewModel.testImage ?? Image("DefaultImage")
        )
        
        
        
        //buttons
        .popupBarItems({
            Button(action: {
                audioManager.playingStatus.toggle()
                if audioManager.playingStatus {
                    audioManager.player.resume()
                    
                } else{
                    audioManager.player.pause()
                }
                
            }) {
                Image(systemName: audioManager.playingStatus ? "pause.fill" : "play.fill")
                    .foregroundColor(.black)
            }
            
            Button(action: {
                isPopupBarPresented = false
                isPopupOpen = true
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            }
        })
        .onAppear{
            //MARK: All of the logic for when the view starts
            if previewstatus{
                audioManager.trackTitle = postViewModel.currentPost?.title ?? "title"
                audioManager.durationSecs = (round((postViewModel.currentPost?.duration ?? 0) * 10) / 10.0)
                audioManager.startPlayer(track: postViewModel.currentPost?.audioUrl ?? "")
                audioManager.playingStatus = true
                postViewModel.ezStatusCheck()
                postViewModel.getImageFromURL()
                postViewModel.fetchUser()
                audioManager.coverArt = postViewModel.coverArtImage
                
            }
        }
        .onDisappear{
            audioManager.player.stop()
        }
        .onChange(of: postViewModel.currentPost) { [currentPost = postViewModel.currentPost] newValue in
            
            //MARK: All of the logic for when the post changes
            if previewstatus{
                if currentPost?.id != newValue?.id {
                    audioManager.trackTitle = newValue?.title ?? "title"
                    audioManager.durationSecs = (round(newValue?.duration ?? 0 * 10) / 10.0)
                    audioManager.startPlayer(track: newValue?.audioUrl ?? "")
                    audioManager.playingStatus = true
                    postViewModel.ezStatusCheck()
                    postViewModel.getImageFromURL()
                    postViewModel.fetchUser()
                    audioManager.coverArt = postViewModel.coverArtImage
                    
                }
            }
        }
        
        
        
    }
    
    
}

struct PlayerView_Previews: PreviewProvider {
    
    static let pst = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est.", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        PlayerView(isPopupBarPresented: .constant(true), isPopupOpen: .constant(false), previewstatus: false, postViewModel: PostViewModel(post: pst), showPosterProfile: .constant(false))
    }
}

