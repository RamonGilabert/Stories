import UIKit

protocol FinaleViewDelegate {

  func resetButtonDidPress()
  func menuButtonDidPress()
}

class FinaleView: UIView {

  struct Dimensions {
    static let landscape: CGFloat = UIScreen.mainScreen().bounds.height / 1.75

    struct Title {
      static let widthOffset: CGFloat = 80
      static let centerOffset: CGFloat = 30
    }

    struct Button {
      static let width: CGFloat = 190
      static let height: CGFloat = 54
      static let bottomOffset: CGFloat = 90
    }
  }

  struct Constants {
    static let shadow: CGFloat = 10
  }

  lazy var landscape: LandscapeView = LandscapeView()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.attributedText = TextAttributes.monaco(Text.Finale.title)
    label.numberOfLines = 0

    return label
  }()

  lazy var button: GeneralButton = {
    let button = GeneralButton()
    button.layer.cornerRadius = Dimensions.Button.height / 2
    button.titleLabel?.font = Font.Finale.button
    button.backgroundColor = Color.Finale.general
    button.setTitle(Text.Finale.button, forState: .Normal)
    button.setTitleColor(Color.Finale.button, forState: .Normal)
    button.addTarget(self, action: #selector(restartButtonDidPress), forControlEvents: .TouchUpInside)
    button.shadow(Color.Finale.Shadow.button, radius: Constants.shadow)

    return button
  }()

  lazy var menu: UIButton = { [unowned self] in
    let button = UIButton()
    button.layer.borderColor = Color.Engine.Button.general.CGColor
    button.layer.borderWidth = EngineView.Dimensions.Menu.border
    button.layer.cornerRadius = EngineView.Dimensions.Menu.size / 2
    button.backgroundColor = Color.Engine.Button.background
    button.shadow(Color.Engine.Button.shadow, radius: 10)
    button.addTarget(self, action: #selector(menuButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  var delegate: FinaleViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)

    [landscape, titleLabel, button, menu].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func restartButtonDidPress() {
    delegate?.resetButtonDidPress()
  }

  func menuButtonDidPress() {
    delegate?.menuButtonDidPress()
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      landscape.widthAnchor.constraintEqualToAnchor(widthAnchor),
      landscape.heightAnchor.constraintEqualToConstant(Dimensions.landscape),
      landscape.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      landscape.topAnchor.constraintEqualToAnchor(topAnchor),

      titleLabel.widthAnchor.constraintEqualToAnchor(widthAnchor, constant: -Dimensions.Title.widthOffset),
      titleLabel.topAnchor.constraintEqualToAnchor(centerYAnchor, constant: Dimensions.Title.centerOffset),
      titleLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor),

      button.widthAnchor.constraintEqualToConstant(Dimensions.Button.width),
      button.heightAnchor.constraintEqualToConstant(Dimensions.Button.height),
      button.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
      button.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -Dimensions.Button.bottomOffset),

      menu.widthAnchor.constraintEqualToConstant(EngineView.Dimensions.Menu.size),
      menu.heightAnchor.constraintEqualToConstant(EngineView.Dimensions.Menu.size),
      menu.topAnchor.constraintEqualToAnchor(topAnchor, constant: EngineView.Dimensions.Menu.topOffset),
      menu.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -EngineView.Dimensions.Menu.rightOffset)
      ])
  }
}
