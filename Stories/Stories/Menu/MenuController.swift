import UIKit
import Transition

protocol MenuControllerDelegate {

}

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

  lazy var menuView: MenuView = { [unowned self] in
    let view = MenuView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self
    
    return view
  }()

  var delegate: MenuControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    gradientLayer.removeFromSuperlayer()
    view.addSubview(menuView)

    setupConstraints()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    menuView.tableView.reloadData()
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

extension MenuController: MenuViewDelegate {

  func buttonDidPress(title: String) {
    switch(title) {
    case Text.Menu.backStory:
      break
    case Text.Menu.story:
      break
    case Text.Menu.end:
      break
    case Text.Menu.motivation:
      break
    case Text.Menu.github:
      break
    case Text.Menu.contact:
      break
    default:
      menuButtonDidPress()
    }
  }

  func menuButtonDidPress() {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
