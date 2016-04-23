import UIKit
import Transition

class MenuController: GeneralController {

  lazy var transition: Transition = {
    let transition = Transition() { controller, show in
      guard let controller = controller as? MenuController else { return }
      controller.view.alpha = show ? 1 : 0
    }

    transition.spring = (0.6, 0.4)
    transition.animationDuration = 1

    return transition
  }()

  lazy var menuView: MenuView = {
    let view = MenuView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    gradientLayer.removeFromSuperlayer()
    view.addSubview(menuView)

    setupConstraints()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    menuView.shouldAnimate = true
  }

  // MARK - Constraints

  func setupConstraints() {
    NSLayoutConstraint.activateConstraints([
      menuView.widthAnchor.constraintEqualToAnchor(view.widthAnchor),
      menuView.heightAnchor.constraintEqualToAnchor(view.heightAnchor),
      menuView.topAnchor.constraintEqualToAnchor(view.topAnchor),
      menuView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
      ])
  }
}
