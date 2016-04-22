import UIKit

protocol EngineViewDelegate {

  func menuButtonDidPress()
}

class EngineView: UIView {

  struct Dimensions {
    struct Menu {
      static let size: CGFloat = 42
      static let shadow: CGFloat = 10
      static let border: CGFloat = 2
      static let topOffset: CGFloat = 24
      static let rightOffset: CGFloat = Menu.topOffset
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
    button.translatesAutoresizingMaskIntoConstraints = false
    button.shadow(Color.Engine.Button.shadow, radius: 10)
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

    [menu].forEach { addSubview($0) }

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func menuButtonDidPress() {
    delegate?.menuButtonDidPress()
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      menu.widthAnchor.constraintEqualToConstant(Dimensions.Menu.size),
      menu.heightAnchor.constraintEqualToConstant(Dimensions.Menu.size),
      menu.topAnchor.constraintEqualToAnchor(topAnchor, constant: Dimensions.Menu.topOffset),
      menu.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -Dimensions.Menu.rightOffset)
      ])
  }
}
