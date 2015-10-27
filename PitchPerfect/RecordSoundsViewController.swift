//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/20/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import UIKit
import AVFoundation

enum RecordState {
    case Stopped
    case Recording
    case Paused
}

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    //var isRecording: Bool = false
    let textRecording = "Recording!"
    let textRecord = "Tap to record!"
    let textResume = "Resume!"
    var recordState: RecordState = .Stopped
    
    let recorder = RecordAudioHelper()
    let pitchPerfectModel = PitchPerfectModel()
    
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var stopButton: UIButton!
    
    @IBAction func recordButtonTouch(sender: UIButton) {
        switch recordState {
        case .Stopped:
            recorder.recordWithPermission(setup: true, doneRecordingCallback: doneRecordingCallback)
            recordLabel.text = textRecording
            stopButton.hidden = false
            recordState = .Recording
        case .Recording:
            // pause code here
            break
        
        default:
            break
        }
    }
    
    func doneRecordingCallback(url: NSURL) -> Void {
        print("doneRecordingCallback = \(url)")
        pitchPerfectModel.audioUrl = url
        
        let playSoundsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("playSoundsView") as! PlaySoundsViewController
        playSoundsViewController.pitchPerfectModel = pitchPerfectModel
        self.navigationController?.pushViewController(playSoundsViewController, animated: true)
    }
    
    @IBAction func stopButtonTouch(sender: UIButton) {
        recordState = .Stopped
        recorder.stopRecording()
    }
    
    override func viewWillAppear(animated: Bool) {
        // initial state of the view
        recordLabel.text = textRecord
        stopButton.hidden = true
        recordState = .Stopped
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