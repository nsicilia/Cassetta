//
//  PlayerView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/24/22.
//

import SwiftUI
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
    
    
    let post: Post
    
    //PlayerState
    @State var previewstatus: Bool = true
    @StateObject var audioManager = AudioManager()
    
    //Test info
    @StateObject var postInfoVM: PostInfoViewModel
    
    
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
                    
                    PlayerContentView(postInfoVM: postInfoVM, post: post).tag(0)
                    
                    CommentsView().tag(1)
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
        .popupTitle(verbatim: post.title)
        //image
        .popupImage(
           // Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: post.imageUrl)!)) ?? UIImage(named: "GenericPhotoIcon")!).resizable()
            Image("DefaultImage").resizable()
        )
        
        
        //buttons
        .popupBarItems({
            Button(action: {
                // isPlaying.toggle()
            }) {
                Image(systemName: "play.fill")
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
            if previewstatus{
                audioManager.trackTitle = post.title
                audioManager.durationSecs = (round(post.duration * 10) / 10.0) 
                audioManager.startPlayer(track: post.audioUrl)
                //print("DEBUG: \(audioManager.player.state)")
            }
        }
        .onDisappear{
            audioManager.player.stop()
            
        }
        
        
        
    }
    
    
}

struct PlayerView_Previews: PreviewProvider {
    
    static let pst = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        PlayerView(isPopupBarPresented: .constant(true), isPopupOpen: .constant(false), post: pst , previewstatus: false, postInfoVM: PostInfoViewModel(post: pst))
    }
}

