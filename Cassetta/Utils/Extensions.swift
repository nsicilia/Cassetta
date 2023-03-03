//
//  Extensions.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 9/13/22.
//

import UIKit
import Foundation
import AVFoundation
import SwiftUI

extension UIApplication{
    func endEdit(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
///Extents the UIScreen to return the full dimentions of the screen
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


extension Date{
    
    func toString(dateFormat format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
}


extension AVMutableCompositionTrack {
    func append(url: URL) {
        let newAsset = AVURLAsset(url: url)
        let range = CMTimeRangeMake(start: CMTime.zero, duration: newAsset.duration)
        let end = timeRange.end
        print(end)
        if let track = newAsset.tracks(withMediaType: AVMediaType.audio).first {
            try! insertTimeRange(range, of: track, at: end)
        }
        
    }
}


//Extension to check if headphones are connected to the device
extension AVAudioSession {

    static var isHeadphonesConnected: Bool {
        return sharedInstance().isHeadphonesConnected
    }

    var isHeadphonesConnected: Bool {
        return !currentRoute.outputs.filter { $0.isHeadphones }.isEmpty
    }

}
// support extension to the AVAudioSession
extension AVAudioSessionPortDescription {
    var isHeadphones: Bool {
        return portType == AVAudioSession.Port.headphones
    }
}


extension DateComponentsFormatter {
    
    static let abbreviated: DateComponentsFormatter = {
        print("Initializing DateComponentsFormatter.abbreviated")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        return formatter
    }()
    
    
    static let positional: DateComponentsFormatter = {
        print("Initializing DateComponentsFormatter.abbreviated")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()
}

//Hides keyboard when clicking out the a textfield
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let standardAppearance = UITabBarAppearance()

        standardAppearance.backgroundColor = .white
       

        tabBar.standardAppearance = standardAppearance
    }
}


///Adds dynamic resizing
extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
