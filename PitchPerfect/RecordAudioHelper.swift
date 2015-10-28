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
    var doneRecordingCallback: ((NSURL) -> Void)?
    let session: AVAudioSession = AVAudioSession.sharedInstance()
    
    func recordWithPermission(setup setup:Bool, doneRecordingCallback callback:((url: NSURL) -> Void)) {
        doneRecordingCallback = callback
        
        do {
            try session.setActive(true)
        }
        catch let err {
            print("Recorder Setting active category Error!")
            print(err)
        }

        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if (granted) {
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
            print("could not set session category")
            print(error.localizedDescription)
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("could not make session active")
            print(error.localizedDescription)
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
    
    func stop() {
        recorder?.stop()
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
        }
        catch let error{
            print("Recorded Stop Error")
            print(error)
        }
    }
    
    func pause() {
        recorder?.pause()
    }
    
    func resume() {
        recorder?.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder,
        successfully flag: Bool) {
            print("finished recording \(flag)")
            doneRecordingCallback!(recorder.url)
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder,
        error: NSError?) {
            if let e = error {
                print("Error during recording")
                print("\(e.localizedDescription)")
            }
    } 
}