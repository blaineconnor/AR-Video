//
//  Coordinator.swift
//  AR-Video
//
//  Created by Fatih Emre Sarman on 11.07.2024.
//

import AVFoundation

class Coordinator {
    var player: AVPlayer?
    
    @objc func handleTap() {
        player?.seek(to: CMTime.zero)
        player?.play()
    }
}
