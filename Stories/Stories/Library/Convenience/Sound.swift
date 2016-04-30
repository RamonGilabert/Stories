import UIKit
import AVFoundation

struct Sound {

  static let bundle = NSBundle.mainBundle()
  static let firstTyping = NSURL(fileURLWithPath: bundle.pathForResource("first_typing", ofType: "wav") ?? "")
  static let secondTyping = NSURL(fileURLWithPath: bundle.pathForResource("second_typing", ofType: "wav") ?? "")
  static let thirdTyping = NSURL(fileURLWithPath: bundle.pathForResource("third_typing", ofType: "wav") ?? "")

  static var typings: [AVAudioPlayer] = []

  static func prepareTyping() {
    let sounds = [firstTyping, secondTyping, thirdTyping]
    var typings: [AVAudioPlayer] = []

    for sound in sounds {
      do {
        let player = try AVAudioPlayer(contentsOfURL: sound)
        typings.append(player)
      } catch {  }
    }

    self.typings = typings
  }

  static func type() {
    let sounds = [1104, 1105]
    let index = Int(arc4random_uniform(UInt32(sounds.count)))

    AudioServicesPlaySystemSound(sounds[index])
  }
}
