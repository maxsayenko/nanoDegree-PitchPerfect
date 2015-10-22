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
    var isRecording: Bool = false
    let textRecording = "Recording!"
    let textRecord = "Record!"
    let textResume = "Resume!"
    
    let audioHelper = AudioHelper()
    let recorder = RecordAudioHelper()
    let pitchPerfectModel = PitchPerfectModel()
    
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var stopButton: UIButton!
    
    func doneRecordingCallback(url: NSURL) -> Void {
        print("doneRecordingCallback = \(url)")
        pitchPerfectModel.audioUrl = url
        
        let playSoundsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("playSoundsView") as! PlaySoundsViewController
        playSoundsViewController.pitchPerfectModel = pitchPerfectModel
        self.navigationController?.pushViewController(playSoundsViewController, animated: true)
    }
    
    @IBAction func recordButtonTouch(sender: UIButton) {
        if(isRecording) {
            recordLabel.text = textResume
        } else {
            //audioHelper.recordWithPermission(setup: true)
            recorder.recordWithPermission(setup: true, doneRecordingCallback: doneRecordingCallback)
            recordLabel.text = textRecording
            stopButton.hidden = false
        }
        isRecording = !isRecording
    }
    
    @IBAction func stopButtonTouch(sender: UIButton) {
        recorder.stopRecording()

        //audioHelper.play()
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
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder,
        successfully flag: Bool) {
            print("finished recording \(flag)")
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder,
        error: NSError?) {
            if let e = error {
                print("audioRecorderEncodeErrorDidOccur = \(e.localizedDescription)")
            }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        if let e = error {
            print("audioPlayerDecodeErrorDidOccur = \(e.localizedDescription)")
        }
    }
}

//extension RecordSoundsViewController : AVAudioRecorderDelegate, AVAudioPlayerDelegate {
//    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder,
//        successfully flag: Bool) {
//            print("finished recording \(flag)")
//    }
//
//    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder,
//        error: NSError?) {
//            if let e = error {
//                print("audioRecorderEncodeErrorDidOccur = \(e.localizedDescription)")
//            }
//    }
//
//    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
//        print("finished playing \(flag)")
//    }
//
//    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
//        if let e = error {
//            print("audioPlayerDecodeErrorDidOccur = \(e.localizedDescription)")
//        }
//    }
//}

