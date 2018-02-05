import Foundation
import AVFoundation

public class AudioPlayer {
    
    public static let sharedInstance = AudioPlayer()
    private var player: AVAudioPlayer?
    
    func play(sound: Data) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.player = try AVAudioPlayer(data: sound)
            
            guard let player = self.player else {
                print("Unable to initialise sound player.")
                return
            }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stop() {
        guard let player = self.player else {
            return
        }
        guard player.isPlaying else {
            return
        }
        
        player.stop()
    }
    
}
