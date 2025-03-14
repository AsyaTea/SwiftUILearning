//
//  SoundsBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 08/05/2024.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()  //Singleton
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
    
}

struct SoundsBootcamp: View {
        
    var body: some View {
        VStack(spacing: 40) {
            Button("Play Sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            
            Button("Play Sound 2") {
                SoundManager.instance.playSound(sound: .badum)
            }
        }
    }
}

#Preview {
    SoundsBootcamp()
}
