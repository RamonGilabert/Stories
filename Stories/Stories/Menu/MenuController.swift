import UIKit
import Transition

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
      delegate?.menuShouldPresentController(.Story)
    case Text.Menu.backStory:
      delegate?.menuShouldPresentController(.Interactive)
    case Text.Menu.end:
      delegate?.menuShouldPresentController(.End)
    case Text.Menu.motivation:
      delegate?.menuShouldPresentController(.Motivation)
    case Text.Menu.github:
      menuOpenDidPress(.Github)
    case Text.Menu.contact:
      menuOpenDidPress(.Contact)
    default:
      menuButtonDidPress()
    }

    menuButtonDidPress()
  }

  func menuButtonDidPress() {
    dismissViewControllerAnimated(true, completion: nil)
  }

  func menuOpenDidPress(controller: Controllers) {
    dismissViewControllerAnimated(true, completion: {
      self.delegate?.menuShouldPresentController(controller)
    })
  }
}
