//
//  NotificationsView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/15/22.
//

import SwiftUI
import Firebase

struct NotificationsView: View {
    @ObservedObject var viewModel = NotificationsViewModel()
    
    //For the LNPopup & Playerview
    @Binding var isPopupBarPresented: Bool
    @Binding var isPopupOpen: Bool
    
    //Universal Post Object
    @ObservedObject var postViewModel: PostViewModel
    
    init(isPopupBarPresented: Binding<Bool>, isPopupOpen: Binding<Bool>, postViewModel: PostViewModel){
        self._isPopupBarPresented = isPopupBarPresented
        self._isPopupOpen = isPopupOpen
        self.postViewModel = postViewModel
    }
    
    
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 8){
                ForEach(viewModel.notifications) { notification in
                    //NotificationCell(notification: notification)
                    NotificationCell(viewModel: NotificationCellViewModel(notification: notification), isPopupBarPresented: $isPopupBarPresented, isPopupOpen: $isPopupOpen, postViewModel: postViewModel)
                }
            }
            .padding(.top)
        }
        
        .background(Color("CassettaTan"))
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var post = Post(audioUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", category: "News", description: "Description", dislikes: 2, imageUrl: "https://images.unsplash.com/photo-1555992336-fb0d29498b13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80", likes: 4, ownerFullname: "Jessica Johnson", ownerImageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", ownerUid: "ddd", ownerUsername: "jessica", timestamp: Timestamp(), title: "5 Shocking Facts About Records That Will Change the Way You Listen to Music Forever!", duration: 4.0, listens: 3)
    
    static var previews: some View {
        NotificationsView(isPopupBarPresented: .constant(false), isPopupOpen: .constant(false), postViewModel: PostViewModel(post: post))
    }
}
