//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/20/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {
    
    var isRecording: Bool = false
    let textRecording = "Recording!"
    let textRecord = "Record!"
    
    @IBOutlet var recordLabel: UILabel!
    
    @IBAction func recordButtonTouch(sender: UIButton) {
        if(isRecording) {
            recordLabel.text = textRecord
        } else {
            recordLabel.text = textRecording
        }
        print(isRecording)
        isRecording = !isRecording
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

