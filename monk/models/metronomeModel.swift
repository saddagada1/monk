//
//  metronomeModel.swift
//  monk
//
//  Created by flighty on 2024-01-10.
//

import Foundation
import AVFoundation

enum MetronomeError: Error {
    case failedToLoadAudioFiles
    case audioEngineFailedToStart
    case failedToLoadAudioBuffers
}

class Metronome {
    static let defaultInstance = try! Metronome(
        clickUrl: Bundle.main.url(
            forResource: "default-low", withExtension: "flac"
        )!,
        accentUrl: Bundle.main.url(
            forResource: "default-hi", withExtension: "flac"
        )!
    )
    
    private let audioPlayerNode: AVAudioPlayerNode
    private let audioEngine: AVAudioEngine
    private let clickFile: AVAudioFile
    private let accentFile: AVAudioFile

    private var currentBuffer: AVAudioPCMBuffer?
    
    init(clickUrl: URL, accentUrl: URL) throws {
        do {
            clickFile = try AVAudioFile(forReading: clickUrl)
            accentFile = try AVAudioFile(forReading: accentUrl)
        } catch let error {
            print(error.localizedDescription)
            throw MetronomeError.failedToLoadAudioFiles
        }
            
        audioPlayerNode = AVAudioPlayerNode()
            
        audioEngine = AVAudioEngine()
        audioEngine.attach(self.audioPlayerNode)
            
        audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: clickFile.processingFormat)
        
        do {
            try audioEngine.start()
        } catch let error {
            print(error.localizedDescription)
            throw MetronomeError.audioEngineFailedToStart
        }
    }
    
    func stop() {
        audioPlayerNode.stop()
    }

    var isPlaying: Bool {
        audioPlayerNode.isPlaying
    }

    func play(bpm: Double, timeSignature: Double, subdivisions: [Int]) {
        let buffer: AVAudioPCMBuffer;
        do {
            buffer = try generateBuffer(bpm: bpm, timeSignature: timeSignature, subdivisions: subdivisions)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        

        currentBuffer = buffer

        if audioPlayerNode.isPlaying {
            audioPlayerNode.stop()
        }

        audioPlayerNode.play()

        audioPlayerNode.scheduleBuffer(
            buffer,
            at: nil,
            options: [.interruptsAtLoop, .loops]
        )
    }
    
    private func generateBuffer(bpm: Double, timeSignature: Double, subdivisions: [Int]) throws -> AVAudioPCMBuffer {
        clickFile.framePosition = 0
        accentFile.framePosition = 0
        
        let tempo = (timeSignature * bpm) / 4
            
        let interval = AVAudioFrameCount(clickFile.processingFormat.sampleRate * 60 / tempo)
        
        let bufferClick = AVAudioPCMBuffer(pcmFormat: clickFile.processingFormat,
                                                   frameCapacity: interval)!
        let bufferAccent = AVAudioPCMBuffer(pcmFormat: accentFile.processingFormat,
                                                   frameCapacity: interval)!
    
        do {
            try clickFile.read(into: bufferClick)
            try accentFile.read(into: bufferAccent)
        } catch let error {
            print(error.localizedDescription)
            throw MetronomeError.failedToLoadAudioBuffers
        }
        
        bufferClick.frameLength = interval;
        bufferAccent.frameLength = interval;
            
        let bufferBar = AVAudioPCMBuffer(pcmFormat: clickFile.processingFormat,
                                             frameCapacity: UInt32(subdivisions.count) * interval)!
        bufferBar.frameLength = UInt32(subdivisions.count) * interval
            
        let channelCount = Int(clickFile.processingFormat.channelCount)
        let clickArray = Array(
            UnsafeBufferPointer(start: bufferClick.floatChannelData![0],
                                count: channelCount * Int(interval))
        )
        let accentArray = Array(
            UnsafeBufferPointer(start: bufferAccent.floatChannelData![0],
                                count: channelCount * Int(interval))
        )
            
        var barArray = [Float]()
        for beat in subdivisions {
            if (beat == 1) {
                barArray.append(contentsOf: accentArray)
            } else {
                barArray.append(contentsOf: clickArray)
            }
        }
        bufferBar.floatChannelData!.pointee.update(from: barArray,
                                                    count: channelCount * Int(bufferBar.frameLength))
        return bufferBar
    }
}
