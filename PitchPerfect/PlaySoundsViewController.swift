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
    let player = PlayAudioHelper()
    var player2: AudioEngineHelper = AudioEngineHelper()
    
    @IBAction func snailButtonTouch(sender: UIButton) {

    }
    
    @IBAction func rabbitButtonTouch(sender: UIButton) {
        player2.playChipmunkSound()
    }
    
    @IBAction func squirellButtonTouch(sender: UIButton) {

    }
    
    @IBAction func darthVaderButtonTouch(sender: UIButton) {

    }
    
    override func viewDidLoad() {
        //self.navigationController?.navigationBarHidden = false
        player2 = AudioEngineHelper(model: pitchPerfectModel!)
        
        super.viewDidLoad()
        
        //print("PlaySoundsViewController url = \(pitchPerfectModel?.audioUrl)")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}