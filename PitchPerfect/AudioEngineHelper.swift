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
    var audioEngine: AVAudioEngine! = AVAudioEngine()
    var audioFile: AVAudioFile!
    
    override init() {
    }
    
    init(model: PitchPerfectModel) {
        do {
            audioFile = try AVAudioFile(forReading: model.audioUrl!)
        }
        catch let error {
            print("File load ERROR!")
            print(error)
        }
    }

    func playChipmunkSound() {
        commonAudioFunction(1000, typeOfChange: "pitch")
    }
    
    func playSnailSound() {
        commonAudioFunction(1/2, typeOfChange: "rate")
    }
    
    func playRabbitSound() {
        commonAudioFunction(2, typeOfChange: "rate")
    }
    
    func playDarthVaderSound() {
        commonAudioFunction(-1000, typeOfChange: "pitch")
    }
    
    func commonAudioFunction(audioChangeNumber: Float, typeOfChange: String){
        let audioPlayerNode = AVAudioPlayerNode()

        audioPlayerNode.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioEngine.attachNode(audioPlayerNode)
        
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        
        if (typeOfChange == "rate") {
            changeAudioUnitTime.rate = audioChangeNumber
        } else {
            changeAudioUnitTime.pitch = audioChangeNumber
        }
        
        audioEngine.attachNode(changeAudioUnitTime)
        audioEngine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        audioEngine.connect(changeAudioUnitTime, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: audioEngineCompletionHandler)
        
        //audioPlayerNode.scheduleBuffer(<#T##buffer: AVAudioPCMBuffer##AVAudioPCMBuffer#>, completionHandler: audioEngineCompletionHandler)
        
        
        do {
           try audioEngine.start()
        }
        catch let error {
            print("Audio Engine StartError")
            print(error)
        }
        
        audioPlayerNode.play()
    }
    
    func audioEngineCompletionHandler() -> Void {
        print("audio engine finished playing")
    }
}