import SwiftUI
import AVFoundation

var player: AVAudioPlayer!

func playSound(sound: String) {
    let url = Bundle.main.url(forResource: sound, withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    
    do {
        
        player = try AVAudioPlayer(contentsOf: url!)
        player.volume = 0.8
        player?.play()
        
    } catch {
        print("error")
    }
    
}
