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
    label.isAccessibilityElement = true
    label.accessibilityTraits = UIAccessibilityTraitStaticText

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

  var delegate: FinaleViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)

    [landscape, titleLabel, button].forEach {
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
      button.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -Dimensions.Button.bottomOffset)
      ])
  }
}
