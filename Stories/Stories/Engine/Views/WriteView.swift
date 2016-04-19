import UIKit

class WriteView: UIView {

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

  init(font: UIFont, text: String) {
    self.font = font
    self.text = text

    super.init(frame: CGRectZero)

    [cursor, label].forEach { addSubview($0) }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Animations

  func startAnimation() {
    UIView.animateKeyframesWithDuration(0.2, delay: 0, options: [.Autoreverse, .Repeat], animations: {
      self.cursor.alpha = 0
    }, completion: nil)
  }
}
