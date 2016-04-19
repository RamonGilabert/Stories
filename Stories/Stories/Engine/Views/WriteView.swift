import UIKit
import Sugar

class WriteView: UIView {

  struct Dimensions {
    struct Cursor {
      static let width: CGFloat = 3
      static let height: CGFloat = 37.5
    }
  }

  lazy var cursor: UIView = {
    let view = UIView()
    view.backgroundColor = Color.Engine.Text.cursor

    return view
  }()

  lazy var label: UILabel = {
    let label = UILabel()
    return label
  }()

  var font: UIFont
  var text: String

  var cursorAnimation = true

  init(font: UIFont, text: String) {
    self.font = font
    self.text = text

    super.init(frame: CGRectZero)

    [cursor, label].forEach { addSubview($0) }

    setupFrames()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Animations

  func startAnimation() {
    cursor(0.4)
  }

  func cursor(duration: NSTimeInterval) {
    UIView.animateWithDuration(0.1, animations: {
      self.cursor.alpha = 1 - self.cursor.alpha
    }, completion: { _ in
      guard self.cursorAnimation else { return }

      delay(duration) { self.cursor(duration) }
    })
  }

  // MARK: - Frames

  func setupFrames() {
    cursor.frame = CGRect(
      x: 0, y: 0, width: Dimensions.Cursor.width, height: Dimensions.Cursor.height)
  }
}
