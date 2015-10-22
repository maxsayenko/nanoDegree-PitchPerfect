//
//  PlayAudioHelper.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/21/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import Foundation
import AVFoundation

class PlayAudioHelper: NSObject, AVAudioPlayerDelegate {
    var player:AVAudioPlayer!
    var pitchPerfectModel: PitchPerfectModel?
    
    func play(model: PitchPerfectModel) {
        player?.stop()
        if let url = model.audioUrl {
            print("about to play \(url)")
            do {
                self.player = try AVAudioPlayer(contentsOfURL: url)
                player.delegate = self
                player.prepareToPlay()
                player.volume = 1.0
                player.play()
            } catch let error as NSError {
                self.player = nil
                print("Error in play = \(error.localizedDescription)")
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
    }
}