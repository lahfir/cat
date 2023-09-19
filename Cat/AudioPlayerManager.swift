//
//  AudioPlayerManager.swift
//  Cat
//
//  Created by Lahfir on 24/09/23.
//

import Foundation
import AVFoundation

class AudioPlayerManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var didFinishPlaying = false
    
    private var audioPlayer: AVAudioPlayer?
    
    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "singlemeow", withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.delegate = self
            audioPlayer?.volume = 1.0
            audioPlayer?.play()
            print("Playing sound: singlemeow.mp3")
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
    
    func finishPlaying(){
        didFinishPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("Finished playing sound successfully")
            didFinishPlaying = true
        } else {
            print("Failed to finish playing sound")
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Decode error occurred: \(error?.localizedDescription ?? "Unknown error")")
    }
}
