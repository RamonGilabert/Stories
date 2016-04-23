import UIKit
import Transition
import Sugar

protocol MenuControllerDelegate {

  func menuShouldPresentController(controller: MenuController.Controllers)
}

class MenuController: GeneralController {

  enum Controllers {
    case Story, Interactive, Motivation, End, Github, Contact
  }

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
    case Text.Menu.story:
      menuButtonDidPress(.Story)
    case Text.Menu.backStory:
      menuButtonDidPress(.Interactive)
    case Text.Menu.end:
      menuButtonDidPress(.End)
    case Text.Menu.motivation:
      menuButtonDidPress(.Motivation)
    case Text.Menu.github:
      menuOpenDidPress(.Github)
    case Text.Menu.contact:
      menuOpenDidPress(.Contact)
    default:
      menuButtonDidPress(nil)
    }
  }

  func menuButtonDidPress() {
    menuButtonDidPress(nil)
  }

  func menuButtonDidPress(controller: Controllers? = nil) {
    if let controller = controller {
      delegate?.menuShouldPresentController(controller)
    }

    dismissViewControllerAnimated(true, completion: nil)
  }

  func menuOpenDidPress(controller: Controllers) {
    dismissViewControllerAnimated(true, completion: {
      delay(0.1) { self.delegate?.menuShouldPresentController(controller) }
    })
  }
}
