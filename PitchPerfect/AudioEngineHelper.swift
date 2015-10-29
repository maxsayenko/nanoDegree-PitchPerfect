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
    
    func playEcho() {
        let echoNode = AVAudioUnitDelay()
        echoNode.delayTime = NSTimeInterval(0.3)
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioPlayerNode.stop()
        self.stop()
        
        audioEngine.attachNode(audioPlayerNode)
        
        // Attach the audio effect node corresponding to the user selected effect
        audioEngine.attachNode(echoNode)
        
        // Connect Player --> AudioEffect
        audioEngine.connect(audioPlayerNode, to: echoNode, format: audioFile.processingFormat)
        // Connect AudioEffect --> Output
        audioEngine.connect(echoNode, to: audioEngine.outputNode, format: audioFile.processingFormat)
        
        //audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler:nil)
        
       // audioEngine.startAndReturnError(nil)
        
        //audioPlayerNode.play()
        
        outputAudio(audioPlayerNode)
    }
    
    func stop() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    private func commonAudioFunction(audioChangeNumber: Float, typeOfChange: String) {
        let audioPlayerNode = AVAudioPlayerNode()

        // Stopping all current processes
        audioPlayerNode.stop()
        self.stop()
        
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
        
        outputAudio(audioPlayerNode)
        
//        // Scheduling file to play. Had to convert it to buffer as in 'scheduleFile' function completionHandler didn't fire correctly
//        do {
//            // Converting file to buffer
//            let file: AVAudioFile = try AVAudioFile(forReading: audioFile.url)
//            let buffer = AVAudioPCMBuffer(PCMFormat: file.processingFormat, frameCapacity: UInt32(file.length))
//            try file.readIntoBuffer(buffer)
//            //  Scheduling buffer
//            audioPlayerNode.scheduleBuffer(buffer, completionHandler: finishPlayingCallback)
//        }
//        catch let error {
//            print("Playing Error")
//            print(error)
//        }
//        
//        do {
//           try audioEngine.start()
//        }
//        catch let error {
//            print("Audio Engine StartError")
//            print(error)
//        }
//        
//        audioPlayerNode.play()
    }
    
    private func outputAudio(playerNode: AVAudioPlayerNode) {
        // Scheduling file to play. Had to convert it to buffer as in 'scheduleFile' function completionHandler didn't fire correctly
        do {
            // Converting file to buffer
            let file: AVAudioFile = try AVAudioFile(forReading: audioFile.url)
            let buffer = AVAudioPCMBuffer(PCMFormat: file.processingFormat, frameCapacity: UInt32(file.length))
            try file.readIntoBuffer(buffer)
            //  Scheduling buffer
            playerNode.scheduleBuffer(buffer, completionHandler: finishPlayingCallback)
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
        
        playerNode.play()
    }
}