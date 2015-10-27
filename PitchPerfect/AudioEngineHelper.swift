//
//  AudioEngineHelper.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/27/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import Foundation
import AVFoundation

class AudioEngineHelper: NSObject, AVAudioPlayerDelegate {
    
    //var recievedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine! = AVAudioEngine()
    var audioFile: AVAudioFile!
    
    init(model: PitchPerfectModel) {
        do {
            audioFile = try AVAudioFile(forReading: model.audioUrl!)
        }
        catch let error as ErrorType {
            print("File load ERROR!")
            print(error)
        }
    }
    
    override init() {

    }
    
    func playChipmunkSound() {
        commonAudioFunction(1000, typeOfChange: "pitch")
    }
    
    func commonAudioFunction(audioChangeNumber: Float, typeOfChange: String){
        var audioPlayerNode = AVAudioPlayerNode()
        
        audioPlayerNode.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioEngine.attachNode(audioPlayerNode)
        
        var changeAudioUnitTime = AVAudioUnitTimePitch()
        
        if (typeOfChange == "rate") {
            changeAudioUnitTime.rate = audioChangeNumber
        } else {
            changeAudioUnitTime.pitch = audioChangeNumber
        }
        
        audioEngine.attachNode(changeAudioUnitTime)
        audioEngine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        audioEngine.connect(changeAudioUnitTime, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        do {
           try audioEngine.start()
        }
        catch let error as ErrorType {
            print("Audio Engine StartError")
            print(error)
        }

        //audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}