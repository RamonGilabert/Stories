import UIKit

struct Engine {

  static let initialTexts = [
    Text.Interactive.one,
    Text.Interactive.two,
    Text.Interactive.three,
    Text.Interactive.four,
    Text.Interactive.five,
    Text.Interactive.six,
    Text.Interactive.seven,
    Text.Interactive.eight,
    Text.Interactive.nine
  ]

  static let initialButtons = [
    (first: Text.Interactive.Buttons.firstOne, second: Text.Interactive.Buttons.firstTwo,
      key: "one", nextFirst: 2, nextSecond: 3),
    (first: Text.Interactive.Buttons.fourOne, second: Text.Interactive.Buttons.fourTwo,
      key: "four", nextFirst: 9, nextSecond: 6),
    (first: Text.Interactive.Buttons.sevenOne, second: Text.Interactive.Buttons.sevenTwo,
      key: "seven", nextFirst: 9, nextSecond: 8)
  ]

  static func response(button: String) -> [String] {
    var initialIndex = 0
    var texts = initialTexts

    for initial in initialButtons {
      if initial.first == button {
        initialIndex = initial.nextFirst
        break
      } else if initial.second == button {
        initialIndex = initial.nextSecond
        break
      }
    }

    for _ in 0..<initialIndex - 1 { texts.removeFirst() }

    return texts
  }

  static func buttons(text: String) -> [String] {
    guard var index = initialTexts.indexOf(text) else { return [] }
    index += 1

    var buttons: [String] = []

    let number = NSNumber(int: Int32(index))
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .SpellOutStyle

    guard let word = formatter.stringFromNumber(number) else { return buttons }

    for button in initialButtons {
      if button.key == word {
        buttons = [button.first, button.second]
      }
    }

    return buttons
  }
}
