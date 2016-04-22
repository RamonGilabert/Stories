import UIKit

protocol EngineViewDelegate {

  func menuButtonDidPress()
}

class EngineView: UIView {

  struct Dimensions {
    struct Menu {
      static let size: CGFloat = 34
      static let shadow: CGFloat = 10
      static let border: CGFloat = 2
    }

    struct Button {
      static let height: CGFloat = 58
      static let offset: CGFloat = 30
      static let shadow: CGFloat = 10
    }
  }

  lazy var menu: UIButton = { [unowned self] in
    let button = UIButton()
    button.layer.borderColor = Color.Engine.Button.general.CGColor
    button.layer.borderWidth = Dimensions.Menu.border
    button.layer.cornerRadius = Dimensions.Menu.size / 2
    button.backgroundColor = Color.Engine.Button.background
    button.addTarget(self, action: #selector(menuButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  lazy var writeView: WriteView = WriteView(font: Font.Engine.text, string: "")

  lazy var leftButton: OptionButton = {
    let button = OptionButton()
    return button
  }()

  lazy var rightButton: OptionButton = {
    let button = OptionButton()
    return button
  }()

  var delegate: EngineViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func menuButtonDidPress() {
    delegate?.menuButtonDidPress()
  }
}
