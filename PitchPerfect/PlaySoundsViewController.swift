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
        player?.stop()
    }
    
    func callback() {
        dispatch_async(dispatch_get_main_queue()) {
            self.disableStopButton()
        }
    }
    
    func disableStopButton() {
        stopButton.enabled = false
    }
    
    func enableStopButton() {
        stopButton.enabled = true
    }
    
    override func viewDidLoad() {
        player = AudioEngineHelper(model: pitchPerfectModel!, finishPlayingCallback: callback)
        stopButton.enabled = false
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}