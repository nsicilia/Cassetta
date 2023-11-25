//
//  BlockSheet.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 11/24/23.
//

import SwiftUI
import Kingfisher

struct BlockSheet: View {
    @ObservedObject var viewModel: ProfileViewModel
    var body: some View {
        VStack{
            KFImage(URL(string: viewModel.user.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding()
            
            Text("Block @\(viewModel.user.username)?")
                .font(.system(size: 20, weight: .semibold))
            
            Label("You will no longer see their posts", systemImage: "exclamationmark.triangle.fill")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.red)
                .padding(.top, 8)
            
            Label("They will not be notified", systemImage: "bell.slash.fill")
                .font(.system(size: 15, weight: .semibold))
                .padding(.top, 8)
            
            Label("You can unblock them in settings", systemImage: "gearshape.fill")
                .font(.system(size: 15, weight: .semibold))
                .padding(.top, 8)
            
            Button {
                //todo: block the user
            } label: {
                Text("Block")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 250, height: 40)
                    .foregroundColor(.white)
                    .background(Color(.red).brightness(-0.15))
                    .cornerRadius(10)
            }
            .padding(.top, 28)
                
            Spacer()
        }
        .padding(.top, 48)
            .presentationDetents([ .medium, .large])
            .presentationDragIndicator(.automatic)
    }
}

#Preview {
    BlockSheet(viewModel: ProfileViewModel(user: User(username: "name", email: "email@email.com", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-256b6.appspot.com/o/profile_images%2F16B6A869-E2CE-4138-8D1C-7D8DA9C9A5E2?alt=media&token=5cf97352-08b8-4698-b71d-31b390a52b52", fullname: "Jane Doeinton")))
}
