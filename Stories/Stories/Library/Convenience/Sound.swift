import UIKit
import AVFoundation

struct Sound {

  static let bundle = NSBundle.mainBundle()
  static let menuURL = NSURL(fileURLWithPath: bundle.pathForResource("menu", ofType: "wav") ?? "")
  static let menuItemURL = NSURL(fileURLWithPath: bundle.pathForResource("menu_item", ofType: "wav") ?? "")

  static var menuPlayer = AVAudioPlayer()
  static var itemPlayer = AVAudioPlayer()

  static func prepareSounds() {
    do {
      let menu = try AVAudioPlayer(contentsOfURL: menuURL)
      menuPlayer = menu

      let item = try AVAudioPlayer(contentsOfURL: menuItemURL)
      itemPlayer = item
    } catch {  }
  }

  static func type() {
    let sounds: [SystemSoundID] = [1104, 1105]
    let index = Int(arc4random_uniform(UInt32(sounds.count)))

    AudioServicesPlaySystemSound(sounds[index])
  }

  static func menu() {
    menuPlayer.play()
  }

  static func item() {
    itemPlayer.play()
  }
}
