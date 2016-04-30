import UIKit
import Ripple

class GeneralController: UIViewController {

  struct Dimensions {
    struct Menu {
      static let size: CGFloat = 42
      static let shadow: CGFloat = 10
      static let border: CGFloat = 2
      static let topOffset: CGFloat = 24
      static let rightOffset: CGFloat = Menu.topOffset
    }
  }

  lazy var gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [Color.Background.top.CGColor, Color.Background.bottom.CGColor]

    return layer
  }()

  lazy var tapGesture: UITapGestureRecognizer = { [unowned self] in
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: #selector(handleTapGesture))

    return gesture
  }()

  lazy var menu: UIButton = { [unowned self] in
    let button = UIButton()
    button.layer.borderColor = Color.Engine.Button.general.CGColor
    button.layer.borderWidth = Dimensions.Menu.border
    button.layer.cornerRadius = Dimensions.Menu.size / 2
    button.backgroundColor = Color.Engine.Button.background
    button.translatesAutoresizingMaskIntoConstraints = false
    button.accessibilityLabel = Text.Accessibility.Title.menu
    button.accessibilityHint = Text.Accessibility.Hint.menu
    button.isAccessibilityElement = true
    button.shadow(Color.Engine.Button.shadow, radius: 10)
    button.addTarget(self, action: #selector(menuButtonDidPress), forControlEvents: .TouchUpInside)

    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.layer.cornerRadius = 7
    view.clipsToBounds = true
    view.layer.insertSublayer(gradientLayer, atIndex: 0)
    view.insertSubview(menu, atIndex: 10)
    view.addGestureRecognizer(tapGesture)

    generalConstraints()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    gradientLayer.frame = view.bounds
  }

  // MARK: - Action methods

  func menuButtonDidPress() { }

  func handleTapGesture() {
    let location = tapGesture.locationInView(view)

    droplet(location,
            view: view,
            size: 25,
            duration: 1, multiplier: 2.5,
            color: Color.General.ripple)
  }

  // MARK: - Constraints

  func generalConstraints() {
    NSLayoutConstraint.activateConstraints([
      menu.widthAnchor.constraintEqualToConstant(Dimensions.Menu.size),
      menu.heightAnchor.constraintEqualToConstant(Dimensions.Menu.size),
      menu.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: Dimensions.Menu.topOffset),
      menu.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -Dimensions.Menu.rightOffset)
      ])
  }
}
