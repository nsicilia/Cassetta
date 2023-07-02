//
//  NotificationsView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/15/22.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 8){
                ForEach(viewModel.notifications) { notification in
                    NotificationCell(notification: notification)
                }
            }
            .padding(.top)
        }
        
        .background(Color("CassettaTan"))
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
