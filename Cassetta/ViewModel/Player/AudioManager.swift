//
//  AudioManager.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 2/6/23.
//

import Foundation
import AudioStreaming
import AVFAudio
import UIKit
import MediaPlayer

class AudioManager: ObservableObject{
    
    var player = AudioPlayer()
        
    @Published var playingStatus: Bool = true
    
    @Published var trackURLString: String = ""
    
    @Published var trackTitle: String = "Title of the post"
    @Published var durationSecs: Double = 0.0
    
    @Published var coverArt = UIImage(named: "DefaultImage"){
        didSet {
            //addMediaCenterInfo()
           // print("Debug: coverArt")
        }
    }
    
    private var progressTimer: Timer?
    
    
    init() {
        setupRemoteCommandCenter()
    }

    /// Starts the player with the given track
    /// - Parameter track: The URL of the track to play
    /// - Returns: Void
    /// - Throws: None
    func startPlayer(track: String){
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch{
            print("the catcheded arror")
        }
        
        player.play(url: URL(string: track)!)
        
        trackURLString = track
        
        setupRemoteCommandCenter()

    }
    /// Stops the player
    /// - Returns: Void
    /// - Throws: None
    func handleAudioEnd(){
        player.queue(url: URL(string: trackURLString)!)
        }
    
    
    func resumePlayer(){
        player.resume()
        
    }
    
    func pausePlayer(){
        player.pause()
    }
    
    func seekPlayer(timeInSec: Double){
        player.seek(to: timeInSec)
    }
    
    func forwardTen(){
        player.seek(to: player.progress + 10)
    }
    
    func backwardTen(){
        player.seek(to: player.progress - 10)
    }
    
    
     func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [weak self] _ in
            self?.resumePlayer()
            self?.playingStatus = true
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            self?.pausePlayer()
            self?.playingStatus = false
            return .success
        }
        
        commandCenter.skipForwardCommand.addTarget { [weak self] _ in
            self?.forwardTen()
            return .success
        }

        commandCenter.skipBackwardCommand.addTarget { [weak self] _ in
            self?.backwardTen()
            return .success
        }
        
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            if let event = event as? MPChangePlaybackPositionCommandEvent {
                self?.seekPlayer(timeInSec: event.positionTime)
                return .success
            }
            return .commandFailed
        }

        
        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        nowPlayingInfoCenter.nowPlayingInfo = [
            MPMediaItemPropertyTitle: trackTitle,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: 0.0,
            MPMediaItemPropertyPlaybackDuration: durationSecs //,
//            MPMediaItemPropertyArtwork: MPMediaItemArtwork(boundsSize: CGSize(width: 600, height: 600), requestHandler: { size in
//                return self.coverArt!
//            })
        ]
        startTimer()

    }

    
    private func startTimer() {
            progressTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
                var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [:]
                nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self?.player.progress.description
                nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
            }
        }
    
    
//    func addMediaCenterInfo() {
//
//        //guard let post = currentPost else {return}
//
//        var mediaInfo = [String:Any]()
//        mediaInfo[MPMediaItemPropertyTitle] = trackTitle
//       // mediaInfo[MPMediaItemPropertyArtist] = post.ownerUsername
//        mediaInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0.0
//        mediaInfo[MPMediaItemPropertyPlaybackDuration] = durationSecs
//
//        // Convert UIImage to MPMediaItemArtwork
////        if let coverrtImage = coverArt {
////            let artwork = MPMediaItemArtwork(boundsSize: coverrtImage.size) { _ in
////                return self.coverArt!
////            }
////            mediaInfo[MPMediaItemPropertyArtwork] = artwork
////        }
//
//        MPNowPlayingInfoCenter.default().nowPlayingInfo = mediaInfo
//    }
    
}

