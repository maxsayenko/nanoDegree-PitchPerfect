//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/20/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    let textRecording = "Recording!"
    let textRecord = "Tap to record!"
    let textResume = "Resume!"
    var recordState: RecordState = .Stopped
    
    let recorder = RecordAudioHelper()
    let pitchPerfectModel = PitchPerfectModel()
    
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    @IBAction func recordButtonTouch(sender: UIButton) {
        switch recordState {
        // Start recording
        case .Stopped:
            recorder.recordWithPermission(setup: true, doneRecordingCallback: doneRecordingCallback)
            recordLabel.text = textRecording
            stopButton.hidden = false
            recordState = .Recording
        // Pause recording
        case .Recording:
            recorder.pause()
            recordLabel.text = textResume
            recordState = .Paused
        // Resume from Pause
        case .Paused:
            recorder.resume()
            recordLabel.text = textRecording
            recordState = .Recording
        }
    }
    
    func doneRecordingCallback(url: NSURL) -> Void {
        print("doneRecordingCallback = \(url)")
        pitchPerfectModel.audioUrl = url
        self.performSegueWithIdentifier("showPlaySoundsView", sender: self)
    }
    
    @IBAction func stopButtonTouch(sender: UIButton) {
        recordState = .Stopped
        recorder.stop()
    }
    
    override func viewWillAppear(animated: Bool) {
        // initial state of the view
        recordLabel.text = textRecord
        stopButton.hidden = true
        recordState = .Stopped
        super.viewWillAppear(animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue")
        if(segue.identifier == "showPlaySoundsView") {
            let playSoundsViewController = (segue.destinationViewController as! PlaySoundsViewController)
            playSoundsViewController.pitchPerfectModel = pitchPerfectModel
        }
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