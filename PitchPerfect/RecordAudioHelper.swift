//
//  RecordAudioHelper.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/21/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import Foundation
import AVFoundation

class RecordAudioHelper: NSObject, AVAudioRecorderDelegate {
    var recorder: AVAudioRecorder!
    
    func recordWithPermission(setup setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    print("Permission to record granted")
                    //self.setSessionPlayAndRecord()
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
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        } catch let error as NSError {
            recorder = nil
            print("Error in setupRecorder = \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        recorder?.stop()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder,
        successfully flag: Bool) {
            print("finished recording \(flag)")
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder,
        error: NSError?) {
            if let e = error {
                print("\(e.localizedDescription)")
            }
    } 
}