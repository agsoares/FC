//
//  BackGround3dAudio.swift
//  MadnessDaze
//
//  Created by Rafael on 30/9/15.
//  Copyright © 2015 Paulo Ricardo Ramos da Rosa. All rights reserved.
//

import AVFoundation

class HeartBeatSoundControl: NSObject {
    
    var player = AVAudioPlayerNode()
    var timePitch = AVAudioUnitTimePitch()
    var audioEngine = AVAudioEngine()
    var enviroNode = AVAudioEnvironmentNode()
    var audioFileBuffer = AVAudioPCMBuffer()
    
    
    init(soundName:String,format:String) {
        
        self.player.renderingAlgorithm = AVAudio3DMixingRenderingAlgorithm.HRTF
        let filePath: String = NSBundle.mainBundle().pathForResource(soundName, ofType: format)!
        let fileURL: NSURL = NSURL(fileURLWithPath: filePath)
        let audioFile = try? AVAudioFile(forReading: fileURL)
        let audioFormat = audioFile!.processingFormat
        let audioFrameCount = UInt32(audioFile!.length)
        
        self.audioFileBuffer = AVAudioPCMBuffer(PCMFormat: audioFormat, frameCapacity: audioFrameCount)
        do {
            try audioFile!.readIntoBuffer(audioFileBuffer)
        } catch _ {
        }
        let mainMixer = audioEngine.mainMixerNode
        
        //timePitch.pitch = 1000
        audioEngine.attachNode(enviroNode)
        audioEngine.attachNode(player)
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(player, to: timePitch, format: audioFile!.processingFormat)
        audioEngine.connect(timePitch, to:enviroNode, format: audioFileBuffer.format)
        audioEngine.connect(enviroNode, to:mainMixer, format: nil)
        
        
        //audioEngine.startAndReturnError(nil)
        do {
            try audioEngine.start()
        } catch _ {
        }
        let  dap = enviroNode.distanceAttenuationParameters as AVAudioEnvironmentDistanceAttenuationParameters
        dap.distanceAttenuationModel =  AVAudioEnvironmentDistanceAttenuationModel.Inverse
        dap.referenceDistance = 10.0;
        dap.maximumDistance = 300.0;
        dap.rolloffFactor = 1.5;
        
        
    }
    
    func playLoop(){
        
        self.player.scheduleBuffer(audioFileBuffer, atTime: nil, options:.Loops, completionHandler: nil)
        self.player.volume = 0.7
        self.player.rate = 0.8
        self.player.play()
    }
    
    func playOnce(){
        self.player.scheduleBuffer(audioFileBuffer, atTime: nil, options: [], completionHandler: nil)
        self.player.play()
    }
    
    func stopPlayer(){
        self.player.stop()
    }
    
    func speedBeat(){
        self.player.rate = 1.6
    }
    
    func normalBeat(){
        self.player.rate = 0.8
    }
    
    
}
