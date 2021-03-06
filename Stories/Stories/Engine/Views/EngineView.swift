import UIKit
import Walker
import Sugar

protocol EngineViewDelegate {

  func textDidEndDisplaying()
  func buttonDidPress(button: String)
}

class EngineView: UIView {

  struct Dimensions {
    static let smallStar: CGFloat = 1
    static let mediumStar: CGFloat = 2
    static let bigStar: CGFloat = 3

    struct Text {
      static let offset: CGFloat = 30
      static let centralOffset: CGFloat = 40
      static let height: CGFloat = 50
    }

    struct Button {
      static let height: CGFloat = 58
      static let offset: CGFloat = 30
      static let shadow: CGFloat = 10
      static let bottom: CGFloat = 45
    }

    struct Shadow {
      static let star: CGFloat = 15
    }
  }

  struct Constants {
    static let velocity: CGFloat = 5
    static let delete: CGFloat = 20
    static let transform: CGFloat = 150
    static let starNumber = 50
  }

  lazy var writeView: WriteView = { [unowned self] in
    let view = WriteView(font: Font.Engine.text, string: "")
    view.text.textAlignment = .Left
    view.centerAlign = false
    view.delegate = self
    view.velocity = Constants.velocity

    return view
  }()

  lazy var leftButton: OptionButton = { [unowned self] in
    let button = OptionButton()
    button.accessibilityHint = Text.Accessibility.Hint.firstOption
    button.addTarget(self, action: #selector(leftButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  lazy var rightButton: OptionButton = { [unowned self] in
    let button = OptionButton()
    button.accessibilityHint = Text.Accessibility.Hint.secondOption
    button.addTarget(self, action: #selector(rightButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  var writeConstraint = NSLayoutConstraint()
  var delegate: EngineViewDelegate?
  var currentButtons: [String] = []

  override init(frame: CGRect) {
    super.init(frame: frame)

    [writeView, leftButton, rightButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    prepareStars([Dimensions.smallStar, Dimensions.mediumStar, Dimensions.bigStar], Constants.starNumber)
    
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func leftButtonDidPress() {
    guard let text = leftButton.titleForState(.Normal) else { return }

    Sound.item()

    animateButtons(false, left: true)
    delegate?.buttonDidPress(text)
  }

  func rightButtonDidPress() {
    guard let text = rightButton.titleForState(.Normal) else { return }

    Sound.item()

    animateButtons(false)
    delegate?.buttonDidPress(text)
  }

  // MARK: - Animations

  func animateButtons(present: Bool, _ first: String = "", _ second: String = "", left: Bool = false) {
    if first != "" {
      leftButton.setTitle(first, forState: .Normal)
      rightButton.setTitle(second, forState: .Normal)
    }

    spring(leftButton, delay: present || left ? 0 : 0.15, spring: 50, friction: 60, mass: 50) {
      $0.transform = present ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, Constants.transform)
    }

    spring(rightButton, delay: present || left ? 0.15 : 0, spring: 50, friction: 60, mass: 50) {
      $0.transform = present ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, Constants.transform)
    }
  }

  func animateText(string: String, _ buttons: [String] = []) {
    currentButtons = buttons
    writeView.string = string
    writeView.velocity = Constants.velocity

    delay(0.4) {
      self.writeView.startAnimation {
        self.performTextChange(string, buttons)
      }
    }
  }

  func changeText(string: String, buttons: [String] = []) {
    currentButtons = buttons
    writeView.string = string
    writeView.velocity = Constants.velocity

    delay(0.4) {
      self.writeView.velocity = Constants.delete
      self.writeView.deleteAnimation {
        self.writeView.velocity = Constants.velocity

        self.writeView.changeText {
          self.performTextChange(string, buttons)
        }
      }
    }
  }

  func performTextChange(string: String, _ buttons: [String] = []) {
    currentButtons = buttons

    if buttons.isEmpty {
      delay(4) {
        self.writeView.velocity = Constants.delete
        self.writeView.deleteAnimation {
          self.writeView.velocity = Constants.velocity

          delay(0.5) {
            self.delegate?.textDidEndDisplaying()
          }
        }
      }
    } else if let first = buttons.first, last = buttons.last {
      self.animateButtons(true, first, last)
    }
  }

  // MARK: - Helper methods

  func prepareButtons() {
    [leftButton, rightButton].forEach { $0.transform = CGAffineTransformMakeTranslation(0, Constants.transform) }
  }

  // MARK: - Constraints

  func setupConstraints() {
    writeConstraint = writeView.heightAnchor.constraintEqualToConstant(Dimensions.Text.height)

    NSLayoutConstraint.activateConstraints([
      writeView.widthAnchor.constraintEqualToAnchor(widthAnchor, constant: -Dimensions.Text.offset * 2),
      writeConstraint,
      writeView.centerYAnchor.constraintEqualToAnchor(centerYAnchor, constant: -Dimensions.Text.centralOffset),
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

extension EngineView: WriteViewDelegate {

  func writeViewDidUpdateText(height: CGFloat) {
    writeConstraint.constant = height

    setNeedsLayout()
  }
}
