import UIKit

struct TextAttributes {

  static func monaco(text: String, font: UIFont = Font.Finale.title) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(string: text)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 20
    paragraphStyle.alignment = .Center

    attributedString.addAttributes([
      NSFontAttributeName : font,
      NSForegroundColorAttributeName : Color.General.text,
      NSParagraphStyleAttributeName : paragraphStyle,
      ], range: NSRange(location: 0, length: text.characters.count))

    return attributedString
  }
}
