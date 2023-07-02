//
//  NotificationCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/15/22.
//

import SwiftUI
import Kingfisher
import Firebase

struct NotificationCell: View {
    @State private var showPostImage = true
    let notification: Notification
    
    var body: some View {
        HStack {
            //Image
            KFImage(URL(string: notification.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            //Name + Notifiaction
            Text(notification.username)
                .font(.system(size: 14, weight: .semibold))
            +
            Text(notification.type.notificationMessage)
                .font(.system(size: 15))
            
            Spacer()
            
            if notification.type != .follow {
                Image("GenericImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
            } else{
                Button {
                    //Todo
                } label: {
                    Text("Follow")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .font(.system(size: 14, weight: .semibold))
                }

            }
        }
        .padding()
        .background(.white)
        .cornerRadius(15.0)
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("CassettaTan").edgesIgnoringSafeArea(.all)
            NotificationCell(notification: Notification(username: "username", profileImageUrl: "GenericUser", timestamp: Timestamp(), type: NotificationType(rawValue: 1) ?? .comment, uid: ""))
        }
    }
}
