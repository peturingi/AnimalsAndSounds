import UIKit

public class Animal {
    
    let player: AudioPlayer
    let sound: Data
    let image: UIImage
    let icon: UIImage
    let name: String
    
    public init(name: String, image: UIImage, sound: Data, icon: UIImage) {
        player = AudioPlayer()
        self.name = name
        self.image = image
        self.sound = sound
        self.icon = icon
    }
    
    public func emit() {
        self.player.play(sound: self.sound)
    }
    
    public func beQuite() {
        self.player.stop()
    }
    
}
