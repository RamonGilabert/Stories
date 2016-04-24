import UIKit

class GeneralButton: UIButton {

  var initialColor: UIColor? = Color.General.button

  override init(frame: CGRect) {
    super.init(frame: frame)

    addTarget(self, action: #selector(touchDown), forControlEvents: .TouchDown)
    addTarget(self, action: #selector(touchCancel), forControlEvents: .TouchCancel)
    addTarget(self, action: #selector(touchDragInside), forControlEvents: .TouchDragInside)
    addTarget(self, action: #selector(touchDragOutside), forControlEvents: .TouchDragOutside)
    addTarget(self, action: #selector(touchUpInside), forControlEvents: .TouchUpInside)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func touchDown() {
    guard backgroundColor != initialColor?.darker() else { return }

    initialColor = backgroundColor

    UIView.animateWithDuration(0.3, animations: {
      self.backgroundColor = self.backgroundColor?.darker()
    })
  }

  func touchDragInside() {
    touchDown()
  }

  func touchCancel() {
    UIView.animateWithDuration(0.3, animations: {
      self.backgroundColor = self.initialColor
    })
  }

  func touchUpInside() {
    touchCancel()
  }

  func touchDragOutside() {
    touchCancel()
  }
}
