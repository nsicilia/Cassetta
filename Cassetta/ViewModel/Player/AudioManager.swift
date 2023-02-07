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
    
    @Published var trackTitle: String = "Title of the post"
    @Published var coverArt = UIImage(named: "Flower")
    
    private var progressTimer: Timer?
    
    init() {
        setupRemoteCommandCenter()
    }
    
    
    func startPlayer(track: String){
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch{
            print("the catcheded arror")
        }
        
        player.play(url: URL(string: track)!)
        
        print("Duration \(player.duration)")
        print("Test round \(round(player.duration * 10) / 10.0)")
        print("Test ceil \(ceil(player.duration * 10) / 10.0)")
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
    
    
    private func setupRemoteCommandCenter() {
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

        
//        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
//        nowPlayingInfoCenter.nowPlayingInfo = [
//            MPMediaItemPropertyTitle: trackTitle,
//            MPMediaItemPropertyArtwork: MPMediaItemArtwork(boundsSize: CGSize(width: 600, height: 600), requestHandler: { size in
//                return self.coverArt!
//            })
//        ]
        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        nowPlayingInfoCenter.nowPlayingInfo = [
            MPMediaItemPropertyTitle: trackTitle,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: 0.0,
            MPMediaItemPropertyPlaybackDuration: 2200.0,
            MPMediaItemPropertyArtwork: MPMediaItemArtwork(boundsSize: CGSize(width: 600, height: 600), requestHandler: { size in
                return self.coverArt!
            })
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
    
}

