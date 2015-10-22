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
    
    @IBAction func snailButtonTouch(sender: UIButton) {
        if let model = pitchPerfectModel {
            player.play(model)
        }
        
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = false
        super.viewDidLoad()
        
        print("PlaySoundsViewController url = \(pitchPerfectModel?.audioUrl)")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}