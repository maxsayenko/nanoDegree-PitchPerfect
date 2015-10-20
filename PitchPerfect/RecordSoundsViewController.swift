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
    let textResume = "Resume!"
    
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var stopButton: UIButton!
    
    @IBAction func recordButtonTouch(sender: UIButton) {
        if(isRecording) {
            recordLabel.text = textResume
        } else {
            recordLabel.text = textRecording
            stopButton.hidden = false
        }
        isRecording = !isRecording
    }
    
    @IBAction func stopButtonTouch(sender: UIButton) {
        let playSoundsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("playSoundsView") as! PlaySoundsViewController
        self.navigationController?.pushViewController(playSoundsViewController, animated: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        super.viewWillAppear(animated)
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

