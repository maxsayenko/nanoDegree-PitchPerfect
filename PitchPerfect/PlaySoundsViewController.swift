//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/20/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {
    var model: PitchPerfectModel?
    let player = PlayAudioHelper()
    
    @IBAction func snailButtonTouch(sender: UIButton) {
        player.play()
    }
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = false
        super.viewDidLoad()
        
        print("PlaySoundsViewController url = \(model?.audioUrl)")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}