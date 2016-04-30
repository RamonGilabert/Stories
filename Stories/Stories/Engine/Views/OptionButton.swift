import UIKit

class OptionButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)

    layer.cornerRadius = EngineView.Dimensions.Button.height / 2
    layer.borderColor = Color.Engine.Button.general.CGColor
    layer.borderWidth = 2
    titleLabel?.font = Font.Engine.button
    backgroundColor = Color.Engine.Button.background
    isAccessibilityElement = true
    shadow(Color.Engine.Button.shadow, radius: 10)
    setTitleColor(Color.Engine.Button.general, forState: .Normal)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
