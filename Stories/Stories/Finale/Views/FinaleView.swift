import UIKit

class FinaleView: UIView {

  struct Dimensions {
    struct Title {
      static let widthOffset: CGFloat = 80
      static let centerOffset: CGFloat = 20
    }

    struct Button {
      static let width: CGFloat = 190
      static let height: CGFloat = 54
      static let bottomOffset: CGFloat = 100
    }
  }

  struct Constants {
    static let shadow: CGFloat = 10
  }

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

  override init(frame: CGRect) {
    super.init(frame: frame)

    [titleLabel, button].forEach {
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
    // TODO: Handle the delegate.
  }

  // MARK: - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
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
