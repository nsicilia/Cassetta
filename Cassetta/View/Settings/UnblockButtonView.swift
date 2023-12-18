//
//  UnblockButtonView.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/18/23.
//

import SwiftUI

struct UnblockButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel
    let user: User
    @State private var unblockedStatus = false

        var body: some View {
            Button(action: {
                viewModel.unblock(uid: user.id)
                unblockedStatus = true
            }) {
                Text(unblockedStatus ? "Unblocked" : "Unblock")
                    .font(.system(size: 14, weight: unblockedStatus ? .thin : .semibold))
                    .padding(.horizontal, 10)
                    .foregroundColor(unblockedStatus ? .gray : .red)
            }
        }
}

#Preview {
    UnblockButtonView(viewModel: ProfileViewModel(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton")), user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton"))
}
