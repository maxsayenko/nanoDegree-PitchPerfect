//
//  AudioHelper.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/21/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class AudioHelper: NSObject, AVAudioPlayerDelegate {
     var recordSoundsViewControllerDelegate: RecordSoundsViewController?
    
    var recorder: AVAudioRecorder!
    var player:AVAudioPlayer!
    var soundFileURL:NSURL?
    
    func play() {
        recorder?.stop()
        player?.stop()
        
        var url:NSURL?
        if self.recorder != nil {
            url = self.recorder.url
        } else {
            url = self.soundFileURL!
        }
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOfURL: url!)
            player.delegate = self
            print(player.delegate)
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            self.player = nil
            print("Error in play = \(error.localizedDescription)")
        }
        
    }
    
    func setupRecorder() {
        let currentFileName = "pitchPerfectAudioRecord.m4a"
        
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let soundFileURL = documentsDirectory.URLByAppendingPathComponent(currentFileName)
        
        let recordSettings:[String : AnyObject] = [
            AVFormatIDKey: NSNumber(unsignedInt:kAudioFormatAppleLossless),
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        do {
            recorder = try AVAudioRecorder(URL: soundFileURL, settings: recordSettings)
            recorder.delegate = recordSoundsViewControllerDelegate
            recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        } catch let error as NSError {
            recorder = nil
            print("Error in setupRecorder = \(error.localizedDescription)")
        }
        
    }
    
    func recordWithPermission(setup setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    print("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder.record()
                } else {
                    print("Permission to record not granted")
                }
            })
        } else {
            print("requestRecordPermission unrecognized")
        }
    }
    
    func setSessionPlayAndRecord() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("could not set session category. \(error.localizedDescription)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("could not make session active. \(error.localizedDescription)")
        }
    }
    
        func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
            print("finished playing \(flag)")
        }
}


//extension AudioHelper : AVAudioRecorderDelegate, AVAudioPlayerDelegate {

//    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder,
//        successfully flag: Bool) {
//            print("finished recording \(flag)")
//    }
//
//    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder,
//        error: NSError?) {
//            if let e = error {
//                print("\(e.localizedDescription)")
//            }
//    }
//
//    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
//        print("finished playing \(flag)")
//    }
//
//    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
//        if let e = error {
//            print("\(e.localizedDescription)")
//        }
//    }
//}
