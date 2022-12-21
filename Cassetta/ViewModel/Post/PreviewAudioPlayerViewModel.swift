//
//  PreviewAudioPlayerViewModel.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 12/21/22.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class PreviewAudioPlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    //passthrough object
    let objectWillChange = PassthroughSubject<PreviewAudioPlayerViewModel, Never>()
    
    //on var update inform subscribed views
    var isPlaying = false{
        didSet{
            objectWillChange.send(self)
        }
    }
    
    //create instance of AVAudioPlayer  from the AVFoundation framework
    var audioPlayer: AVAudioPlayer!
    
    
    //MARK: Play audio from a passed in URL(a file path for the audio to be played)
    func startPlayback(audio: URL){
        
        //initialize an AVAudioSession shared instance
        let playbackSession = AVAudioSession.sharedInstance()
        
        //If headphones are connected to the device don't override audio output location
        if playbackSession.isHeadphonesConnected {
            do{
                try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                
            } catch{
                print("DEBUG: AudioPlayer - Playing over the device's speakers failed")
            }
            
        }
        else{
            //else overwrite the output audio port set to speaker
            do{
                try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                
            } catch{
                print("DEBUG: AudioPlayer - Playing over the device's speakers failed")
            }
            
        }
        
        
        //play the audio from the given file path
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            //set the AudioPlayer itself as the delegate of the AVAudioPlayer
            audioPlayer.delegate = self
            //play audio
            audioPlayer.play()
            //inform subcribed views that player is running
            isPlaying = true
            
        } catch{
            print("DEBUG: AudioPlayer - Playback failed.")
        }
    }
    
    
    //MARK: Stop audio playback
    func stopPlayback(){
        audioPlayer.stop()
        //inform subcribed views that player has stopped
        isPlaying = false
    }
    
    
    //MARK: Pause audio playback
    func pausePlayback(){
        audioPlayer.pause()
        isPlaying = false
    }
    
    
    //MARK: Reset audio playing status when finished
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag{
            isPlaying = false
        }
    }
    
}
