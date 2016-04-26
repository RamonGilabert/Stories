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

    static let minimumHeight: CGFloat = 60
  }

  struct Constants {
    static let line: CGFloat = 14
  }

  lazy var cursor: UIView = {
    let view = UIView()
    view.backgroundColor = Color.Engine.Text.cursor
    view.alpha = 0

    return view
  }()

  lazy var text: UITextView = { [unowned self] in
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = Constants.line

    let text = UITextView()
    text.typingAttributes = [NSParagraphStyleAttributeName : paragraphStyle]
    text.delegate = self
    text.font = self.font
    text.textColor = Color.General.text
    text.backgroundColor = Color.General.clear
    text.allowsEditingTextAttributes = true
    text.textAlignment = .Center
    text.userInteractionEnabled = false

    return text
  }()

  var font: UIFont {
    didSet {
      text.font = font
    }
  }

  var centerAlign = true {
    didSet {
      setupFrames()
    }
  }

  var string: String

  var velocity: CGFloat = 1
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

  func startAnimation(completion: (() -> ())? = nil) {
    cursor(0.4)

    delay(1.2) {
      self.changeText(completion)
    }
  }

  func deleteAnimation(completion: (() -> ())? = nil) {
    if !text.text.characters.isEmpty {
      let durations = [0.1, 0.15]
      let index = Int(arc4random_uniform(UInt32(durations.count)))

      text.text = text.text.substringToIndex(text.text.endIndex.predecessor())
      textViewDidChange(text)

      delay(durations[index]) {
        self.deleteAnimation(completion)
      }
    } else {
      completion?()
    }
  }

  func cursor(duration: NSTimeInterval) {
    UIView.animateWithDuration(0.1, animations: {
      self.cursor.alpha = 1 - self.cursor.alpha
    }, completion: { _ in
      guard self.cursorAnimation else { self.cursor.alpha = 0; return }

      delay(duration) { self.cursor(duration) }
    })
  }

  func changeText(completion: (() -> ())? = nil) {
    if text.text.length < string.length {
      let nextCharacter = string[string.startIndex.advancedBy(text.text.length)]
      let durations = [0.35, 0.2, 0.3, 0.25, 0.15]
      let index = Int(arc4random_uniform(UInt32(durations.count)))

      text.text.append(nextCharacter)
      textViewDidChange(text)

      delay(durations[index] / Double(velocity)) {
        self.changeText(completion)
      }
    } else {
      completion?()
    }
  }

  // MARK: - Frames

  func setupFrames() {
    let width = UIScreen.mainScreen().bounds.width - WelcomeView.Dimensions.writeOffset
    
    cursor.frame.size = CGSize(width: Dimensions.Cursor.width, height: Dimensions.Cursor.height)
    cursor.frame.origin = CGPoint(x: centerAlign ? (width - cursor.frame.size.width) / 2 : 0, y: 0)
    text.center = center
  }
}

extension WriteView: UITextViewDelegate {

  func textViewDidChange(textView: UITextView) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = Constants.line

    let size = text.text.boundingRectWithSize(
      CGSize(width: frame.width, height: CGFloat.max),
      options: NSStringDrawingOptions.UsesLineFragmentOrigin,
      attributes: [
        NSFontAttributeName : font,
        NSParagraphStyleAttributeName : paragraphStyle
      ], context: nil).size

    textView.sizeToFit()
    textView.frame.size = CGSize(width: size.width + 10, height: size.height)
    textView.frame.origin.x = centerAlign ? (frame.width - textView.frame.width) / 2 : 0

    frame.size.height = size.height < Dimensions.minimumHeight ? Dimensions.minimumHeight : size.height

    textView.frame.origin.y = (frame.height - textView.frame.height) / 2

    if size.height < Dimensions.minimumHeight {
      cursor.frame.origin.x = textView.frame.maxX + 5
      cursor.center.y = textView.center.y
    } else {
      cursor.frame.origin.x = textView.caretRectForPosition(textView.endOfDocument).origin.x + 15
      cursor.frame.origin.y = textView.frame.height - Dimensions.Cursor.height
    }
  }
}
