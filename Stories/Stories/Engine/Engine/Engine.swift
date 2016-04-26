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
    (first: Text.Interactive.Buttons.firstOne, second: Text.Interactive.Buttons.firstTwo, key: "one"),
    (first: Text.Interactive.Buttons.fourOne, second: Text.Interactive.Buttons.fourTwo, key: "four"),
    (first: Text.Interactive.Buttons.sevenOne, second: Text.Interactive.Buttons.sevenTwo, key: "seven")
  ]

  static func response(button: String) -> String {
    return ""
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
