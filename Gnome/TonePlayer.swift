//
//  TonePlayer.swift
//  Gnome
//
//  Created by Connor Kale on 4/27/25.
//  Actually created by ChatGPT on 4/27/25.

import AVFoundation

class TonePlayer {
    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private var format: AVAudioFormat!
    
    init(frequency: Float = 440.0) {
        configureAudioSession()
        setupEngine(frequency: frequency)
    }
    
    private func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback, mode: .default)
        try? session.setActive(true)
    }
    
    private func setupEngine(frequency: Float) {
        let sampleRate: Double = 44100
        let duration: Double = 1.0
        let frameCount = UInt32(sampleRate * duration)
        format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)!
        let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)!
        buffer.frameLength = frameCount
        
        let thetaIncrement = 2.0 * .pi * Double(frequency) / sampleRate
        var theta = 0.0
        let channelData = buffer.floatChannelData![0]
        
        for frame in 0..<Int(frameCount) {
            channelData[frame] = Float(sin(theta))
            theta += thetaIncrement
        }

        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: format)

        try? engine.start()
        player.scheduleBuffer(buffer, at: nil, options: .loops)
        player.play()
    }

    func updateFrequency(to frequency: Float) {
        player.stop()
        engine.disconnectNodeInput(player)
        engine.detach(player)
        engine.stop()
        
        setupEngine(frequency: frequency)
    }
}
