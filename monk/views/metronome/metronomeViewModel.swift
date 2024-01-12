//
//  metronomeViewModel.swift
//  monk
//
//  Created by flighty on 2024-01-11.
//

import Foundation

class MetronomeViewModel: ObservableObject {
    @Published var tempo = 120.0
    @Published var timeSignature = 4.0
    @Published var subdivisions = [1,0,0,0,0,0]
    
    private let metronome: Metronome;
    
    init(metronome: Metronome) {
        self.metronome = metronome
    }
    
    var isPlaying: Bool {
        metronome.isPlaying
    }
    
    func changeTempo (tempo: Double){
        if (metronome.isPlaying) {
            metronome.stop()
        }
        self.tempo = tempo;
    }
    
    func changeSubdivisions (index: Int, isAccent: Bool){
        if (metronome.isPlaying) {
            metronome.stop()
        }
        self.subdivisions[index] = isAccent ? 0 : 1;
    }
    
    func play () {
        metronome.play(bpm: self.tempo, timeSignature: self.timeSignature, subdivisions: self.subdivisions)
    }
    
    func stop () {
        metronome.stop()
    }
    
    func toggle () {
        if (metronome.isPlaying) {
            self.stop()
        } else {
            self.play()
        }
    }
}
