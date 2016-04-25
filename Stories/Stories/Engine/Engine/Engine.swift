import UIKit

struct Engine {

  private static let initialTexts = [
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

  private static let initialButtons = [
    (first: Text.Interactive.Buttons.firstOne, second: Text.Interactive.Buttons.firstTwo),
    (first: Text.Interactive.Buttons.fourOne, second: Text.Interactive.Buttons.fourTwo),
    (first: Text.Interactive.Buttons.sevenOne, second: Text.Interactive.Buttons.sevenTwo)
  ]

  static var texts = Engine.initialTexts
  static var buttons = Engine.initialButtons

  static func next(text: String) -> String {
    return ""
  }

  static func response(button: String) -> String {
    return ""
  }

  static func buttons(text: String) -> [String] {
    return []
  }
}
