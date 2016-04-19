import UIKit
import Sugar

class WriteView: UIView {

  struct Dimensions {
    struct Cursor {
      static let width: CGFloat = 3
      static let height: CGFloat = 37.5
    }

    struct Text {
      static let offset: CGFloat = 80
    }
  }

  lazy var cursor: UIView = {
    let view = UIView()
    view.backgroundColor = Color.Engine.Text.cursor

    return view
  }()

  lazy var text: UITextView = { [unowned self] in
    let text = UITextView()
    text.delegate = self
    text.font = self.font
    text.textColor = Color.General.text
    text.backgroundColor = Color.General.clear
    text.allowsEditingTextAttributes = true

    return text
  }()

  var font: UIFont
  var string: String

  var cursorAnimation = true

  init(font: UIFont, string: String) {
    self.font = font
    self.string = string

    super.init(frame: CGRectZero)

    [text, cursor].forEach { addSubview($0) }

    setupFrames()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Animations

  func startAnimation() {
    cursor(0.4)
    changeText()
  }

  func cursor(duration: NSTimeInterval) {
    UIView.animateWithDuration(0.1, animations: {
      self.cursor.alpha = 1 - self.cursor.alpha
    }, completion: { _ in
      guard self.cursorAnimation else { return }

      delay(duration) { self.cursor(duration) }
    })
  }

  func changeText() {
    if text.text.length < string.length {
      let nextCharacter = string[string.startIndex.advancedBy(text.text.length)]
      let durations = [0.35, 0.2, 0.3, 0.25, 0.15]
      let index = Int(arc4random_uniform(UInt32(durations.count)))

      text.text.append(nextCharacter)
      textViewDidChange(text)

      delay(durations[index]) {
        self.changeText()
      }
    }
  }

  // MARK: - Frames

  func setupFrames() {
    cursor.frame = CGRect(
      x: 0, y: 0, width: Dimensions.Cursor.width, height: Dimensions.Cursor.height)
    text.center = center
  }
}

extension WriteView: UITextViewDelegate {

  func textViewDidChange(textView: UITextView) {
    let size = text.text.boundingRectWithSize(
      frame.size, options: NSStringDrawingOptions.UsesLineFragmentOrigin,
      attributes: [NSFontAttributeName : font], context: nil).size

    textView.sizeToFit()
    textView.frame.size = CGSize(width: size.width + 10, height: size.height)
    textView.frame.origin.x = (frame.width - textView.frame.width) / 2

    frame.size.height = size.height
    cursor.frame.origin.x = textView.frame.maxX + 5
    cursor.center.y = textView.center.y - 1
  }
}
