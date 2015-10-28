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
        enableStopButton()
        player!.playSnailSound()
    }
    
    @IBAction func rabbitButtonTouch(sender: UIButton) {
        enableStopButton()
        player!.playRabbitSound()
    }
    
    @IBAction func squirellButtonTouch(sender: UIButton) {
        enableStopButton()
        player!.playChipmunkSound()
    }
    
    @IBAction func darthVaderButtonTouch(sender: UIButton) {
        enableStopButton()
        player!.playDarthVaderSound()
    }
    
    @IBAction func stopButtonTouch(sender: UIButton) {
        print("stop")
        player?.stop()
    }
    
    func callback() {
        disableStopButton()
    }
    
    func disableStopButton() {
        stopButton.enabled = false
        // Button doesn't change the state on the view
        stopButton.alpha = 0.5
    }
    
    func enableStopButton() {
        stopButton.enabled = true
        stopButton.alpha = 1
    }
    
    override func viewDidLoad() {
        player = AudioEngineHelper(model: pitchPerfectModel!, finishPlayingCallback: callback)
        stopButton.enabled = false
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}