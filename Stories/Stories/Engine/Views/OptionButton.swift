import UIKit

class OptionButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)

    titleLabel?.font = Font.Engine.button
    backgroundColor = Color.Engine.Button.background
    shadow(Color.Engine.Button.shadow, radius: 10)
    setTitleColor(Color.Engine.Button.general, forState: .Normal)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
