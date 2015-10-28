//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/20/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {
    var pitchPerfectModel: PitchPerfectModel?
    var player: AudioEngineHelper?
    @IBOutlet var stopButton: UIButton!
    
    @IBAction func snailButtonTouch(sender: UIButton) {
        audioPlaying()
        player!.playSnailSound()
    }
    
    @IBAction func rabbitButtonTouch(sender: UIButton) {
        audioPlaying()
        player!.playRabbitSound()
    }
    
    @IBAction func squirellButtonTouch(sender: UIButton) {
        audioPlaying()
        player!.playChipmunkSound()
    }
    
    @IBAction func darthVaderButtonTouch(sender: UIButton) {
        audioPlaying()
        player!.playDarthVaderSound()
    }
    
    @IBAction func stopButtonTouch(sender: UIButton) {
        print("stop")
        player?.stop()
    }
    
    func audioPlaying() {
        stopButton.enabled = true
    }
    
    func callback() {
        stopButton.enabled = false
    }
    
    override func viewDidLoad() {
        player = AudioEngineHelper(model: pitchPerfectModel!, finishPlayingCallback: callback)
        stopButton.enabled = false
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}