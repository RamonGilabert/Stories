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

    struct Text {
      static let offset: CGFloat = 30
      static let height: CGFloat = 50
    }

    struct Button {
      static let height: CGFloat = 58
      static let offset: CGFloat = 30
      static let shadow: CGFloat = 10
      static let bottom: CGFloat = 45
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

  lazy var leftButton: OptionButton = { [unowned self] in
    let button = OptionButton()
    button.addTarget(self, action: #selector(leftButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  lazy var rightButton: OptionButton = { [unowned self] in
    let button = OptionButton()
    button.addTarget(self, action: #selector(rightButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  var delegate: EngineViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)

    [menu, writeView, leftButton, rightButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func menuButtonDidPress() {
    delegate?.menuButtonDidPress()
  }

  func leftButtonDidPress() {
    // TODO: Change the buttons and stuff.
  }

  func rightButtonDidPress() {
    // TODO: Change the buttons and stuff.
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      menu.widthAnchor.constraintEqualToConstant(Dimensions.Menu.size),
      menu.heightAnchor.constraintEqualToConstant(Dimensions.Menu.size),
      menu.topAnchor.constraintEqualToAnchor(topAnchor, constant: Dimensions.Menu.topOffset),
      menu.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -Dimensions.Menu.rightOffset),

      writeView.widthAnchor.constraintEqualToAnchor(widthAnchor, constant: -Dimensions.Text.offset * 2),
      writeView.heightAnchor.constraintGreaterThanOrEqualToConstant(Dimensions.Text.height),
      writeView.centerYAnchor.constraintEqualToAnchor(centerYAnchor),
      writeView.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: Dimensions.Text.offset),

      leftButton.widthAnchor.constraintEqualToAnchor(widthAnchor, multiplier: 0.5, constant: -Dimensions.Button.offset),
      leftButton.heightAnchor.constraintEqualToConstant(Dimensions.Button.height),
      leftButton.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: Dimensions.Button.offset / 1.5),
      leftButton.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -Dimensions.Button.bottom),

      rightButton.widthAnchor.constraintEqualToAnchor(widthAnchor, multiplier: 0.5, constant: -Dimensions.Button.offset),
      rightButton.heightAnchor.constraintEqualToConstant(Dimensions.Button.height),
      rightButton.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -Dimensions.Button.offset / 1.5),
      rightButton.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -Dimensions.Button.bottom)
      ])
  }
}
