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
        player!.playSnailSound()
    }
    
    @IBAction func rabbitButtonTouch(sender: UIButton) {
        player!.playRabbitSound()
    }
    
    @IBAction func squirellButtonTouch(sender: UIButton) {
        player!.playChipmunkSound()
    }
    
    @IBAction func darthVaderButtonTouch(sender: UIButton) {
        player!.playDarthVaderSound()
    }
    
    @IBAction func stopButtonTouch(sender: UIButton) {
    }
    
    func callback() {
        print("Doneee")
    }
    
    override func viewDidLoad() {
        player = AudioEngineHelper(model: pitchPerfectModel!, finishPlayingCallback: callback)
        stopButton.enabled = false
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}