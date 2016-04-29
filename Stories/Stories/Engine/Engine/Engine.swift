import UIKit

struct Engine {

  static let initialTexts = [
    Text.Interactive.one, Text.Interactive.two, Text.Interactive.three,
    Text.Interactive.four, Text.Interactive.five, Text.Interactive.six,
    Text.Interactive.seven, Text.Interactive.eight, Text.Interactive.nine,
    Text.Interactive.ten, Text.Interactive.eleven, Text.Interactive.twelve,
    Text.Interactive.thirteen, Text.Interactive.fourteen, Text.Interactive.fiveteen,
    Text.Interactive.sixteen, Text.Interactive.seventeen, Text.Interactive.eighteen,
    Text.Interactive.nineteen, Text.Interactive.twenty, Text.Interactive.twentyOne,
    Text.Interactive.twentyTwo, Text.Interactive.twentyThree, Text.Interactive.twentyFour,
    Text.Interactive.twentyFive, Text.Interactive.twentySix, Text.Interactive.twentySeven,
    Text.Interactive.twentyEight, Text.Interactive.twentyNine, Text.Interactive.thirty,
    Text.Interactive.thirtyOne, Text.Interactive.thirtyTwo, Text.Interactive.thirtyThree,
    Text.Interactive.thirtyFour, Text.Interactive.thirtyFive, Text.Interactive.thirtySix
  ]

  static let initialButtons = [
    (first: Text.Interactive.Buttons.firstOne, second: Text.Interactive.Buttons.firstTwo,
      key: "one", nextFirst: 2, nextSecond: 3),
    (first: Text.Interactive.Buttons.fourOne, second: Text.Interactive.Buttons.fourTwo,
      key: "four", nextFirst: 9, nextSecond: 6),
    (first: Text.Interactive.Buttons.sevenOne, second: Text.Interactive.Buttons.sevenTwo,
      key: "seven", nextFirst: 9, nextSecond: 8),
    (first: Text.Interactive.Buttons.nineOne, second: Text.Interactive.Buttons.nineTwo,
      key: "nine", nextFirst: 10, nextSecond: 11),
    (first: Text.Interactive.Buttons.elevenOne, second: Text.Interactive.Buttons.elevenTwo,
      key: "eleven", nextFirst: 12, nextSecond: 13),
    (first: Text.Interactive.Buttons.thirteenOne, second: Text.Interactive.Buttons.thireteenTwo,
      key: "thirteen", nextFirst: 14, nextSecond: 14),
    (first: Text.Interactive.Buttons.fourteenOne, second: Text.Interactive.Buttons.fourteenTwo,
      key: "fourteen", nextFirst: 15, nextSecond: 18),
    (first: Text.Interactive.Buttons.seventeenOne, second: Text.Interactive.Buttons.seventeenTwo,
      key: "seventeen", nextFirst: 19, nextSecond: 19),
    (first: Text.Interactive.Buttons.twentyTwoOne, second: Text.Interactive.Buttons.twentyTwoTwo,
      key: "twenty-two", nextFirst: 23, nextSecond: 23),
    (first: Text.Interactive.Buttons.twentyFiveOne, second: Text.Interactive.Buttons.twentyFiveTwo,
      key: "twenty-five", nextFirst: 26, nextSecond: 26),
    (first: Text.Interactive.Buttons.twentyEightOne, second: Text.Interactive.Buttons.twentyEightTwo,
      key: "twenty-eight", nextFirst: 29, nextSecond: 30),
    (first: Text.Interactive.Buttons.thirtyOneOne, second: Text.Interactive.Buttons.thirtyOneTwo,
      key: "thirty-one", nextFirst: 34, nextSecond: 32),
    (first: Text.Interactive.Buttons.thirtySixOne , second: Text.Interactive.Buttons.thirtySixTwo,
      key: "thirty-six", nextFirst: 36, nextSecond: 36)
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
