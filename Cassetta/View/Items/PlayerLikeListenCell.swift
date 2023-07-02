//
//  PlayerLikeListenCell.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/10/23.
//

import SwiftUI

struct PlayerLikeListenCell: View {
    @ObservedObject var postViewModel: PostViewModel
    @State private var likeButtonEnabled = true
    @State private var dislikeButtonEnabled = true
    
    var likeValue: Bool { return postViewModel.currentPost?.didLike ?? false }
    var dislikeValue: Bool { return postViewModel.currentPost?.didDislike ?? false }
    
    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 1) {
                Text("173k")
                Text("🎧")
            }
            
            HStack(spacing: 1) {
                Text("13k")
                Text("💬")
            }
            
            // Like button
            Button(action: {
                if likeButtonEnabled {
                    likeButtonEnabled = false
                    likeValue ? postViewModel.unlike() : postViewModel.like()
                    
                    // Enable the button after a cooldown period (e.g., 2 seconds)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        likeButtonEnabled = true
                    }
                }
            }, label: {
                HStack {
                    Text(postViewModel.likeString)
                        .foregroundColor(.black)
                    
                    Image(systemName: likeValue ? "heart.fill" : "heart")
                        .resizable()
                        .foregroundColor(likeValue ? .red : .gray)
                        .frame(width: 20, height: 18)
                }
                .frame(minWidth: postViewModel.currentPost?.likes ?? 0 >= 1000 ? 85 : 0)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
            })
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("CassettaBorder"), lineWidth: 2)
            )
            .disabled(!likeButtonEnabled) // Disable the button when it's not enabled
            
            // Dislike button
            Button(action: {
                if dislikeButtonEnabled {
                    dislikeButtonEnabled = false
                    dislikeValue ? postViewModel.undislike() : postViewModel.dislike()
                    
                    // Enable the button after a cooldown period (e.g., 2 seconds)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        dislikeButtonEnabled = true
                    }
                }
            }, label: {
                HStack {
                    Text(postViewModel.dislikeString)
                        .foregroundColor(.black)
                    
                    Image(systemName: dislikeValue ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .resizable()
                        .foregroundColor(dislikeValue ? .blue : .gray)
                        .frame(width: 21, height: 21)
                }
                .frame(minWidth: postViewModel.currentPost?.dislikes ?? 0 >= 1000 ? 85 : 0)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
            })
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("CassettaBorder"), lineWidth: 2)
            )
            .disabled(!dislikeButtonEnabled) // Disable the button when it's not enabled
        }
        .frame(width: UIScreen.screenWidth)
    }
}


struct PlayerLikeListenCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerLikeListenCell(postViewModel: PostViewModel())
    }
}
