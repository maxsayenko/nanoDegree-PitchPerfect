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
    var finishPlayingCallback: (() -> Void)? = nil
    
    override init() {
    }
    
    init(model: PitchPerfectModel, finishPlayingCallback callback: (() -> Void)?) {
        finishPlayingCallback = callback
        
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
    
    func stop() {
        audioEngine.stop()
        audioEngine.reset()
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
        
        // Scheduling file to play. Had to convert it to buffer as in 'scheduleFile' function completionHandler didn't fire correctly
        do {
            // Converting file to buffer
            let file: AVAudioFile = try AVAudioFile(forReading: audioFile.url)
            let buffer = AVAudioPCMBuffer(PCMFormat: file.processingFormat, frameCapacity: UInt32(file.length))
            try file.readIntoBuffer(buffer)
            //  Scheduling buffer
            audioPlayerNode.scheduleBuffer(buffer, completionHandler: finishPlayingCallback)
        }
        catch let error {
            print("Playing Error")
            print(error)
        }
        
        do {
           try audioEngine.start()
        }
        catch let error {
            print("Audio Engine StartError")
            print(error)
        }
        
        audioPlayerNode.play()
    }
}